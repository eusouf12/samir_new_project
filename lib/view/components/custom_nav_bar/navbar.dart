import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_home_screen/host_home_screen.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../screens/host_part/host_messages_list_screen/host_messages_list_screen.dart';
import '../../screens/host_part/host_profile_screen/host_profile_screen.dart';


class HostNavbar extends StatefulWidget {
  final int currentIndex;

  const HostNavbar({required this.currentIndex, super.key});

  @override
  State<HostNavbar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<HostNavbar> {
  late int bottomNavIndex;

  final List<String> icons = [
    AppIcons.navHome,
    AppIcons.navChat,
    AppIcons.navProfile,

  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(17.r),
          topRight: Radius.circular(17.r),
        ),
        // border: Border.all(color: AppColors.grey_03, width: .2),
       boxShadow: [
         BoxShadow(
            color: AppColors.white_50,
          spreadRadius: 1,
         blurRadius: 4,
         offset: const Offset(3, 0),
         ),
      ],
      ),
      height: 80.h,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          icons.length,
              (index) => InkWell(
            onTap: () => onTap(index),
            borderRadius: BorderRadius.circular(10.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 13.h),
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: index == bottomNavIndex
                        ? AppColors.primary
                        : Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    icons[index],
                    height: 25.h,
                    width: 25.w,
                    color: index == bottomNavIndex
                        ? AppColors.white_50
                        : Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index != bottomNavIndex) {
      setState(() {
        bottomNavIndex = index;
      });

      switch (index) {
        case 0:
          Get.offAll(() => HostHomeScreen());
          break;
        case 1:
          Get.offAll(() => HostMessagesListScreen());
          break;
        case 2:
          Get.offAll(() => HostProfileScreen());
          break;
      }
    }
  }
}