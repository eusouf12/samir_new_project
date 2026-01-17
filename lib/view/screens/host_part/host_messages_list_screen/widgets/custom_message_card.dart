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

  const CustomMessageCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.lastMessage,
    this.time,
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
                      // if (isOnline)
                      //   const Positioned(
                      //     bottom: -2,
                      //     right: -2,
                      //     child: Icon(
                      //       Icons.circle_rounded,
                      //       color: AppColors.green,
                      //       size: 12,
                      //     ),
                      //   ),
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