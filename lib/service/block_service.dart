import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import 'api_url.dart';
import '../utils/ToastMsg/toast_message.dart';

class BlockService extends GetxController {
  static BlockService get to => Get.isRegistered<BlockService>()
      ? Get.find<BlockService>()
      : Get.put(BlockService(), permanent: true);

  static const String _blockedUsersKey = "hostinflu_blocked_user_ids";
  static const String _blockedUsersInfoKey = "hostinflu_blocked_users_info";

  final RxList<String> blockedUserIds = <String>[].obs;
  final RxMap<String, String> blockedUsersInfo = <String, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadBlockedUsers();
  }

  Future<void> loadBlockedUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_blockedUsersKey) ?? [];
      blockedUserIds.assignAll(list);

      final infoJson = prefs.getString(_blockedUsersInfoKey);
      if (infoJson != null && infoJson.isNotEmpty) {
        final Map<String, dynamic> decoded = jsonDecode(infoJson);
        blockedUsersInfo.assignAll(decoded.map((k, v) => MapEntry(k, v.toString())));
      }
    } catch (e) {
      debugPrint("Error loading blocked users: $e");
    }
  }

  bool isBlocked(String? userId) {
    if (userId == null || userId.isEmpty) return false;
    return blockedUserIds.contains(userId);
  }

  Future<void> blockUser({
    required String userId,
    required String userName,
    String? reason,
  }) async {
    if (userId.isEmpty) return;

    if (!blockedUserIds.contains(userId)) {
      blockedUserIds.add(userId);
      blockedUsersInfo[userId] = userName.isNotEmpty ? userName : "User $userId";

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(_blockedUsersKey, blockedUserIds.toList());
        await prefs.setString(_blockedUsersInfoKey, jsonEncode(blockedUsersInfo));
      } catch (e) {
        debugPrint("Error saving blocked user: $e");
      }

      // Notify developer / backend moderation team within 24h as per Apple Guideline 1.2
      _notifyDeveloperOfBlock(userId, userName, reason);

      showCustomSnackBar(
        "User '$userName' has been blocked. Their content has been removed from your feed.",
        isError: false,
      );
    }
  }

  Future<void> unblockUser(String userId) async {
    if (blockedUserIds.contains(userId)) {
      final userName = blockedUsersInfo[userId] ?? "User";
      blockedUserIds.remove(userId);
      blockedUsersInfo.remove(userId);

      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList(_blockedUsersKey, blockedUserIds.toList());
        await prefs.setString(_blockedUsersInfoKey, jsonEncode(blockedUsersInfo));
      } catch (e) {
        debugPrint("Error updating blocked users after unblock: $e");
      }

      showCustomSnackBar("Unblocked $userName", isError: false);
    }
  }

  Future<void> _notifyDeveloperOfBlock(
    String userId,
    String userName,
    String? reason,
  ) async {
    try {
      final Map<String, dynamic> body = {
        "reportType": "Abusive Content / User Block",
        "reason": reason ?? "User blocked by client for inappropriate content or abusive behavior",
        "description": "User '$userName' ($userId) was blocked by the user. Automatic review flag triggered for moderation within 24 hours.",
      };

      await ApiClient.postData(
        ApiUrl.createReport(id: userId),
        jsonEncode(body),
      );
      debugPrint("Developer notified of block for user: $userId");
    } catch (e) {
      debugPrint("Error notifying developer of blocked user: $e");
    }
  }
}
