import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';


class CustomReviewCard extends StatelessWidget {
  final String? comment;
  final String? hostName;
  final String? imageUrl;
  final DateTime? date;
  final double rating;

  const CustomReviewCard({
    super.key,
    this.comment,
    this.hostName,
    this.imageUrl,
    this.date,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl ?? "",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                boxShape: BoxShape.circle,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: hostName ?? "User Name",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        // star
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              size: 16,
                              color: index < rating.toInt()
                                  ? Colors.amber
                                  : Colors.grey[300],
                            );
                          }),
                        ),
                        const SizedBox(width: 10),
                        //time
                        CustomText(
                          text: formatDateFromDateTime(date),
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    //Comment
                    CustomText(
                      text: comment ?? "",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textClr,
                      maxLines: 10,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDateFromDateTime(DateTime? date) {
  if (date == null) return '';

  final now = DateTime.now();
  final difference = now.difference(date.toLocal());

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else {
    // Onek beshi din hoye gele standard format e dekhano bhalo
    return DateFormat('dd MMM yyyy').format(date.toLocal());
  }
}



