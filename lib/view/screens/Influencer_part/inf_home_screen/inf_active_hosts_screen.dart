import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_tab_selected/custom_tab_bar.dart';
import 'controller/inf_home_controller.dart';

class InfActiveHostsScreen extends StatelessWidget {
   InfActiveHostsScreen({super.key});

   final infHomeController =Get.find<InfHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Active Hosts"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomTextField(
              fillColor: AppColors.white,
              fieldBorderColor: AppColors.primary2,
              isDens: true,
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.textClr),
              prefixIcon: Icon(Icons.search, size: 24),
            ),
            SizedBox(height: 20),

            Column(
              children: List.generate(3, (value){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: AppConstants.girlsPhoto,
                                height: 46,
                                width: 46,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomText(
                                        text: "Mehedi",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        right: 6,
                                      ),
                                      Icon(
                                        Icons.check_circle,
                                        size: 18,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 18,
                                        color: Colors.grey,
                                      ),
                                      CustomText(
                                        text: "Dhaka, Bangladesh",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.amber,
                                      ),
                                      CustomText(
                                        text: "4.8",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          CustomButtonTwo(onTap: (){
                            Get.toNamed(AppRoutes.infActiveHostProfileScreen);
                          },title: "View Profile",height: 46,fillColor: AppColors.primary2,)
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
