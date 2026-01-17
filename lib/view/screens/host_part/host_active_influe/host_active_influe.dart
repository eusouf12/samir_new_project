import 'package:flutter/material.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../host_listing_screen/widgets/custom_active_card.dart';

class HostActiveInflue extends StatelessWidget {
  const HostActiveInflue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Active Influencers"),
      body: Column(
        children: [
          //search
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xffEEF2FF), const Color(0xffECFEFF)],
              ),
            ),
            child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomTextField(
                    isDens: true,
                    fillColor: AppColors.white,
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColors.textClr),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppColors.textClr,
                    ),
                  ),
                ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                CustomActiveCard(
                  name: "Sarah ",
                  username: "sarahtravels",
                  imageUrl: AppConstants.girlsPhoto,
                  tags: ["Travel", "Vlog", "Lifestyle"],
                ),
                CustomActiveCard(
                  name: " Anderson",
                  username: "sarahtravels123",
                  imageUrl: AppConstants.girlsPhoto,
                  tags: ["Travel", "Vlog", "Lifestyle"],
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
