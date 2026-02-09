import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';
class CustomPastDealsCard extends StatelessWidget {
  final String? title;
  final String? hostName;
  final String? imageUrl;
  final DateTime? date;

  const CustomPastDealsCard({
    super.key,
    this.title,
    this.hostName,
    this.imageUrl,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: imageUrl ?? "",
                height: 64,
                width: 64,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title ?? "",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: "By ${hostName }"??"",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffDCFCE7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: CustomText(
                          text: "Completed",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff15803D),
                        ),
                      ),
                      CustomText(
                        left: 20,
                        text: formatDateFromDateTime(date),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textClr,
                      ),
                    ],
                  ),
                ],
              ),
              // IconButton(
              //   color: AppColors.primary,
              //   focusColor: AppColors.primary,
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.play_arrow,
              //     color: AppColors.primary,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


String formatDateFromDateTime(DateTime? date) {
  if (date == null) return '';

  return DateFormat('d MMM yyyy').format(date.toLocal());
}

