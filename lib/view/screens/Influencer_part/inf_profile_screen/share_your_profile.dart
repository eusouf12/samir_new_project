import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../host_part/host_profile_screen/controller/host_profile_controller.dart';

class ShareProfileScreen extends StatelessWidget {
  ShareProfileScreen({super.key});
  final HostProfileController hostProfileController = Get.put(HostProfileController());


  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text("Link copied to clipboard!"),
          ],
        ),
        backgroundColor: Color(0xFFFF7E67),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String role = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      hostProfileController.shareProfile();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar:  CustomRoyelAppbar(leftIcon: true, titleName: "Share Profile",),
      body:Obx((){
        if (hostProfileController.isShareProfileLoading.value) {
          return  Center(
            child: CustomLoader(color: AppColors.primary2,),
          );
        }

        final profileLink = hostProfileController.shareProfileData.value?.shareableLinks.web ?? "";

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomText(text: "Your Public Bio Link", fontSize: 20.sp, fontWeight: FontWeight.bold,),
              SizedBox(height: 12),
              CustomText(text: "Share your HostInflux profile with your audience\nacross all platforms", color: Colors.grey, fontSize: 12.sp, ),
              SizedBox(height: 30),
              // Link Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1F3F5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Your Profile Link", fontSize: 12.sp, fontWeight: FontWeight.w600,),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Text(profileLink, style: TextStyle(color: Colors.black87, fontSize: 14),),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:role=='host'? AppColors.primary : AppColors.primary2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => _copyToClipboard(context, profileLink),
                        icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                        label:CustomText(text: "Copy Link", color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // QR Code Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFF1F3F5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "QR Code", fontSize: 16, fontWeight: FontWeight.w600),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: QrImageView(
                          data: profileLink,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

}