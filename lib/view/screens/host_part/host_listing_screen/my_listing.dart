// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
// import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
// import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
//
// import '../../../../utils/app_const/app_const.dart';
// import '../../../../utils/app_icons/app_icons.dart';
// import '../../../components/custom_image/custom_image.dart';
// import '../../../components/custom_netwrok_image/custom_network_image.dart';
// import '../../../components/custom_text/custom_text.dart';
// class MyListing extends StatelessWidget {
//   const MyListing({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomRoyelAppbar(leftIcon: true,titleName: "My Listing",),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//              CustomTextField(
//                isDens: true,
//                fillColor: Color(0xffF5F5F5),
//                hintText: "Search your listing",
//                hintStyle: TextStyle(color: AppColors.textClr),
//                prefixIcon: Icon(Icons.search,size: 20,color: AppColors.textClr,),
//              ),
//             SizedBox(height: 16),
//             Container(
//               width: MediaQuery.sizeOf(context).width,
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.black.withValues(alpha: 0.1),
//                     blurRadius: 2,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: "Listing Information",
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     bottom: 8,
//                   ),
//                   CustomNetworkImage(
//                     imageUrl: AppConstants.banner,
//                     height: 190.h,
//                     width: MediaQuery.sizeOf(context).width,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomText(
//                         text: "Luxury Beachfront Apartment",
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         maxLines: 2,
//                         bottom: 8,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
//                         decoration: BoxDecoration(
//                           color: AppColors.green,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: CustomText(
//                           text: "Verified",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.white,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         color: AppColors.textClr,
//                         size: 18,
//                       ),
//                       CustomText(
//                         left: 6,
//                         text: "Manhattan, New York",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.textClr,
//                       ),
//                     ],
//                   ),
//                   CustomText(
//                     top: 8,
//                     text:
//                     "Stunning ocean front apartment with panoramic views, modern amenities, and prime location steps from the beach.",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     maxLines: 6,
//                     textAlign: TextAlign.start,
//                     bottom: 8,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.wifi,
//                             color: AppColors.textClr,
//                             size: 18,
//                           ),
//                           CustomText(
//                             left: 4,
//                             text: "Wi-Fi",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.textClr,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.pool,
//                             color: AppColors.textClr,
//                             size: 18,
//                           ),
//                           CustomText(
//                             left: 4,
//                             text: "Pool",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.textClr,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.soup_kitchen,
//                             color: AppColors.textClr,
//                             size: 18,
//                           ),
//                           CustomText(
//                             left: 4,
//                             text: "Kitchen",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.textClr,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.local_parking,
//                             color: AppColors.textClr,
//                             size: 18,
//                           ),
//                           CustomText(
//                             left: 4,
//                             text: "Parking",
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: AppColors.textClr,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12),
//                   Card(
//                     elevation: 0,
//                     color: AppColors.white,
//                     child: Container(
//                       width: MediaQuery.sizeOf(context).width,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Color(0xffF3F4F6),
//                         borderRadius: BorderRadius.all(Radius.circular(13)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomText(
//                             text: "View Listing on Airbnb",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             right: 8,
//                           ),
//                           CustomImage(imageSrc: AppIcons.linkIcon),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
