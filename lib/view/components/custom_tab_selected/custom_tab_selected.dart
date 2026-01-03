import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';

class CustomTabSelector extends StatelessWidget {
  final List<String> tabs;
  final List<String>? numberList;
  final String? countNum;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color? textColor;
  final bool? isTextColorActive;
  final bool? isPadding;


  const CustomTabSelector({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.selectedColor,
    required this.unselectedColor,
    this.textColor,
    this.isTextColorActive = false,
    this.isPadding = true,  this.numberList, this.countNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       width: 0,
      //       color: unselectedColor,
      //     ),
      //   ),
      // ),
      padding: isPadding!
          ? const EdgeInsets.symmetric(horizontal: 2)
          : const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tabs.length, (index) {
            return Padding(
              padding: EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ?  AppColors.primary.withOpacity(0.2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    //color: AppColors.red,
                    // border: Border(
                    //   bottom: BorderSide(
                    //     color: selectedIndex == index
                    //         ? selectedColor
                    //         : Colors.transparent,
                    //     width: 3.0,
                    //   ),
                    // ),
                  ),
                  child:Row(
                    children: [
                      Text(
                        tabs[index],
                        style: GoogleFonts.poppins(
                          color: selectedIndex == index
                              ? selectedColor
                              : isTextColorActive!
                              ? textColor
                              : unselectedColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "(${countNum})"?? "",
                        style: GoogleFonts.poppins(
                          color: selectedIndex == index
                              ? selectedColor
                              : isTextColorActive!
                              ? textColor
                              : unselectedColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}