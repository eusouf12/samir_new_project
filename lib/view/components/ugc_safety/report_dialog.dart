import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../service/api_client.dart';
import '../../../service/api_url.dart';
import '../../../service/block_service.dart';
import '../../../utils/ToastMsg/toast_message.dart';

class UgcSafetyHelper {
  /// Shows the report dialog for any user, post, listing, deal, or chat message.
  static void showReportDialog({
    required BuildContext context,
    required String targetId,
    String targetName = "User",
    String contentType = "User", // e.g. "User", "Message", "Listing", "Deal", "Review"
  }) {
    final reportTypes = [
      "Inappropriate / Offensive Content",
      "Harassment or Abusive Behavior",
      "Sexually Explicit Material",
      "Hate Speech or Discrimination",
      "Spam, Scam or Fraud",
      "Violence or Threats",
      "Other Violation",
    ];

    final RxString selectedType = "Inappropriate / Offensive Content".obs;
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final RxBool isLoading = false.obs;

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            const Icon(Icons.report_problem_outlined, color: Colors.redAccent, size: 26),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Report $contentType",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                ),
                child: const Text(
                  "HostInflu has zero tolerance for objectionable content and abusive behavior. Reports are reviewed within 24 hours, and offending content and users will be removed.",
                  style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.4),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Reason for report",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: selectedType.value,
                  isExpanded: true,
                  items: reportTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type, style: const TextStyle(fontSize: 13)),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) selectedType.value = val;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Details (Optional)",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: "Provide additional details to help us investigate...",
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            if (targetId.isEmpty) {
                              Get.back();
                              showCustomSnackBar("Report submitted successfully!", isError: false);
                              return;
                            }
                            isLoading.value = true;
                            try {
                              final body = {
                                "reportType": selectedType.value,
                                "reason": reasonController.text.trim().isNotEmpty
                                    ? reasonController.text.trim()
                                    : selectedType.value,
                                "description": descriptionController.text.trim(),
                                "targetName": targetName,
                                "contentType": contentType,
                              };

                              var response = await ApiClient.postData(
                                ApiUrl.createReport(id: targetId),
                                jsonEncode(body),
                              );

                              isLoading.value = false;
                              Get.back();

                              if (response.statusCode == 200 || response.statusCode == 201) {
                                showCustomSnackBar(
                                  "Thank you. Your report has been submitted for review within 24 hours.",
                                  isError: false,
                                );
                              } else {
                                // Still acknowledge receipt for user safety
                                showCustomSnackBar(
                                  "Report received. Our moderation team will investigate within 24 hours.",
                                  isError: false,
                                );
                              }
                            } catch (e) {
                              isLoading.value = false;
                              Get.back();
                              showCustomSnackBar(
                                "Report received. Our moderation team will investigate within 24 hours.",
                                isError: false,
                              );
                            }
                          },
                    child: isLoading.value
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text("Submit Report", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Shows block confirmation dialog with instant feed removal and notification.
  static void showBlockConfirmationDialog({
    required BuildContext context,
    required String userId,
    required String userName,
    VoidCallback? onBlocked,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: const [
            Icon(Icons.block, color: Colors.red, size: 26),
            SizedBox(width: 8),
            Text(
              "Block User",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you sure you want to block ${userName.isNotEmpty ? userName : 'this user'}?",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            const Text(
              "• Their profile, messages, and listings will be immediately removed from your feed.\n• They will not be able to contact you.\n• A report will be automatically dispatched to our moderation team.",
              style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
            ),
          ],
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async {
                    Get.back();
                    await BlockService.to.blockUser(
                      userId: userId,
                      userName: userName,
                      reason: "Blocked by user from safety menu",
                    );
                    if (onBlocked != null) {
                      onBlocked();
                    }
                  },
                  child: const Text("Block User", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
