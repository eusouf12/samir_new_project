import 'package:flutter/material.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../../utils/app_icons/app_icons.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_image/custom_image.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_text/custom_text.dart';

class HostSendCollaboarationScreen extends StatelessWidget {
  const HostSendCollaboarationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Send Collaboration",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.girlsPhoto,
                        height: 36,
                        width: 36,
                        boxShape: BoxShape.circle,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Michael Chen",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Host",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textClr,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomImage(imageSrc: AppIcons.arrowBakBak),
                  ),
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.girlsPhoto2,
                        height: 36,
                        width: 36,
                        boxShape: BoxShape.circle,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Michael Chen",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: "Host",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textClr,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              CustomFormCard(
                title: "Select List",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Select Deal",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Offers",
                controller: TextEditingController(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: "Include free stay?",fontSize: 14,fontWeight: FontWeight.w500,),
                  Switch(value: true, onChanged: (value){})
                ],
              ),
              CustomText(text: "Number of Nights",fontSize: 14,fontWeight: FontWeight.w500,bottom: 12,),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textClr.withValues(alpha: .1)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       IconButton(onPressed: (){}, icon: Icon(Icons.remove_circle,color: AppColors.textClr,)),
                       Column(
                         children: [
                           CustomText(text: "2",fontSize: 24,fontWeight: FontWeight.w700,),
                           CustomText(text: "nights",fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.textClr,),
                         ],
                       ),
                       IconButton(onPressed: (){}, icon: Icon(Icons.add_circle,color: AppColors.textClr,))
                      ]
                  ),
                ),
              ),
              SizedBox(height: 16),
              CustomFormCard(title: "Start Date", controller: TextEditingController()),
              CustomFormCard(title: "End Date", controller: TextEditingController()),
              SizedBox(height: 16),
              CustomButtonTwo(
                onTap: (){},
                title: "Send Request",),
              SizedBox(height: 16,),
              CustomButtonTwo(
                onTap: (){},
                fillColor: AppColors.red_02,
                title: "Send Request",),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
