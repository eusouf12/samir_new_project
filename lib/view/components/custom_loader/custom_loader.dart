import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../utils/app_colors/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color:color?? AppColors.primary,
        // color: AppColors.appBarBackground,
        size: 40.h,
      ),
    );
  }
}
