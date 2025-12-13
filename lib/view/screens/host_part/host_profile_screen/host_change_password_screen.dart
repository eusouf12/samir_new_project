import 'package:flutter/material.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_from_card/custom_from_card.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
class HostChangePasswordScreen extends StatelessWidget {
  const HostChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Change Password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40.0),
        child: Column(
          children: [
            CustomFormCard(
              title: "Old Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            CustomFormCard(
              title: "New Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            CustomFormCard(
              title: "Confirm New Password",
              isPassword: true,
              controller: TextEditingController(),
            ),
            Spacer(),
            CustomButtonTwo(
              onTap: () {},
              title: "UPDATE PASSWORD",
              textColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
