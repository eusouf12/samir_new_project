import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomMessageCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String lastMessage;
  final DateTime? time;
  final bool isActive;
  final String? lastSeen;

  const CustomMessageCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    this.time,
    required this.isActive,
    this.lastSeen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.textClr.withValues(alpha: .1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left side
              Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomNetworkImage(
                        imageUrl: profileImage,
                        height: 40,
                        width: 40,
                        boxShape: BoxShape.circle,
                      ),

                      if (isActive)
                        const Positioned(
                          bottom: -2,
                          right: -2,
                          child: Icon(
                            Icons.circle,
                            color: AppColors.green,
                            size: 12,
                          ),
                        )
                      else if (getShortLastSeen(lastSeen).isNotEmpty)
                        Positioned(
                          bottom: -4,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              getShortLastSeen(lastSeen),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: lastMessage,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),

              CustomText(
                    text: formatChatTime(time),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                    bottom: 8,
                  ),


            ],
          ),
        ),
      ),
    );
  }
}
String formatChatTime(DateTime? dateTime) {
  if (dateTime == null) return '';

  final localTime = dateTime.toLocal();
  return DateFormat('hh:mm a').format(localTime);
}

String formatLastSeen(String? isoString) {
  if (isoString == null || isoString.isEmpty) return '';

  final DateTime lastSeen =
  DateTime.parse(isoString).toLocal();

  final Duration diff =
  DateTime.now().difference(lastSeen);

  if (diff.inSeconds < 60) {
    return "just now";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes}m ago";
  } else if (diff.inHours < 24) {
    return "${diff.inHours}h ago";
  } else if (diff.inDays < 30) {
    return "${diff.inDays}d ago";
  } else if (diff.inDays < 365) {
    return "${(diff.inDays / 30).floor()}mo ago";
  } else {
    return "${(diff.inDays / 365).floor()}y ago";
  }
}

String getShortLastSeen(String? isoString) {
  if (isoString == null || isoString.isEmpty) return '';

  final lastSeen = DateTime.parse(isoString).toLocal();
  final diff = DateTime.now().difference(lastSeen);

  if (diff.inMinutes < 1) {
    return "1m";
  } else if (diff.inMinutes < 60) {
    return "${diff.inMinutes}m";
  } else if (diff.inHours < 24) {
    return "${diff.inHours}h";
  } else {
    return ""; // days বা month হলে কিছুই না
  }
}