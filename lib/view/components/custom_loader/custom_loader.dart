import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../helper/shared_prefe/shared_prefe.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_const/app_const.dart';

class CustomLoader extends StatelessWidget {
   CustomLoader({super.key, this.color});
  final Color? color;
  String? role ;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      role = await SharePrefsHelper.getString(AppConstants.role);
    });

    return Center(
      child: SpinKitThreeBounce(
        color:  color ?? AppColors.primary,
        // color: AppColors.appBarBackground,
        size: 40.h,
      ),
    );
  }
}
