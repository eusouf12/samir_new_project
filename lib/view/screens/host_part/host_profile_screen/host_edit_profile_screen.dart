import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_gradient/custom_gradient.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/host_profile_controller.dart';


class HostEditProfileScreen extends StatelessWidget {
  HostEditProfileScreen({super.key});
  final HostProfileController profileController = Get.put(HostProfileController());
  final page = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return CustomGradient(
      color1: Color(0xFF0C7A43),

      child: Scaffold(
          appBar: CustomRoyelAppbar(leftIcon: true, titleName: 'Edit Profile', color: AppColors.black,),
          body:Obx((){
            if (profileController.rxUserStatus.value == Status.loading) {
              return const Center(child: CustomLoader());
            }

            if (profileController.userData.value == null) {
              return const Center(child: CustomText(text: "Profile not found", fontSize: 16,),);
            }
            final userData = profileController.userData.value!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 120.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: ClipOval(child:profileController.selectedImage.value != null
                                    ? Image.file(profileController.selectedImage.value!, height: 70.h, width: 70.w, fit: BoxFit.cover,)
                                    : CustomNetworkImage(
                                  imageUrl:userData.image.isNotEmpty ? ApiUrl.baseUrl + userData.image: AppConstants.profileImage2,
                                  height: 70.h,
                                  width: 70.w,
                                  boxShape: BoxShape.circle,
                                ),
                                )),
                          ),
                        ),
                        Positioned(
                          right: 120.w,
                          bottom: 10.w,
                          child: GestureDetector(
                            onTap: () {
                              profileController.pickImageFromGallery();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: page == "host" ? AppColors.green : AppColors.primary2,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.edit, size: 15, color: AppColors.white,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Name
                    Obx(() => CustomFormCard(
                      title: 'Name',
                      fontSize: 16,
                      hintText: 'Enter Your Name',
                      controller: profileController.nameController.value,
                    )),
                    //user name
                    Obx(() => CustomFormCard(
                      title: 'User Name',
                      fontSize: 16,
                      hintText: 'Enter Your UserName',
                      controller: profileController.userNameController.value,
                    )),
                    // Email
                    Obx(() => CustomFormCard(
                      title: 'Email',
                      hintText: 'Enter Your Email',
                      controller: profileController.emailController.value,
                      readOnly: true,
                    )),
                    // Date of Birth
                    Obx(() => CustomFormCard(
                      title: 'Date Of Birth',
                      hintText: 'DD-MM-YYYY',
                      controller: profileController.dateOfBirthController.value,
                    )),
                    //gender
                    Obx(() => CustomFormCard(
                      title: 'Gender',
                      hintText: 'Male/Female',
                      controller: profileController.genderController.value,
                    )),
                    //country
                    Obx(() => CustomFormCard(
                      title: 'Country',
                      hintText: 'United State',
                      controller: profileController.countryController.value,
                    )),
                    //phone
                    Obx(() => CustomFormCard(
                      title: 'Phone Number',
                      hintText: 'Enter Your Phone Number',
                      controller: profileController.phoneNumberController.value,
                    )),

                    SizedBox(height: 20),
                    Obx((){
                      if (profileController.updateProfileLoading.value) {
                        return const CustomLoader();
                      }
                      return  CustomButton(
                        onTap: (){
                          profileController.updateProfile();
                        },
                        title: 'Save',
                        textColor: AppColors.white,
                        borderRadius: 50,
                        fillColor:page == "host" ? AppColors.primary : AppColors.primary2
                      );
                    })

                  ],
                ),
              ),
            );
          })
      ),
    );
  }
}