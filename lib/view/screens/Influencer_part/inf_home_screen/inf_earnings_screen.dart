import 'package:flutter/material.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../components/custom_text/custom_text.dart';

class InfEarningsScreen extends StatelessWidget {
  const InfEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Earnings"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.primary2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Total Balance",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
                CustomText(
                  text: "\$2,450.00",
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Payments",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  bottom: 20,
                ),
                Column(
                  children: List.generate(3, (value) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.1),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Beach front Villa",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Collaboration",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Nov 3, 2025",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textClr,
                                ),
                              ],
                            ),
                            CustomText(
                              text: "+\$500",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                CustomButtonTwo(
                  onTap: () {},
                  title: "Withdraw via Stripe",
                  fillColor: AppColors.primary2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
