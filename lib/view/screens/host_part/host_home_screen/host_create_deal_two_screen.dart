import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button_two.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../components/custom_text/custom_text.dart';
class HostCreateDealTwoScreen extends StatefulWidget {
  const HostCreateDealTwoScreen({super.key});

  @override
  State<HostCreateDealTwoScreen> createState() => _HostCreateDealTwoScreenState();
}

class _HostCreateDealTwoScreenState extends State<HostCreateDealTwoScreen> {

  String selectedPlatform = "TikTok";
  int postCount = 4;

  final List<Map<String, dynamic>> platforms = [
    {
      "name": "TikTok",
      "icon": Icons.play_arrow, // Replace with proper asset
      "color": Colors.black,
    },
    {
      "name": "Instagram",
      "icon": Icons.camera_alt,
      "color": Colors.pink,
    },
    {
      "name": "YouTube",
      "icon": Icons.video_collection,
      "color": Colors.red,
    },
  ];

  final List<Map<String, dynamic>> contentTypes = [
    {
      "title": "Post",
      "subtitle": "Feed post with image/video",
      "icon": Icons.image,
      "selected": false,
    },
    {
      "title": "Reels",
      "subtitle": "Short video content",
      "icon": Icons.movie_creation_outlined,
      "selected": false,
    },
    {
      "title": "Story",
      "subtitle": "24-hour story content",
      "icon": Icons.timelapse,
      "selected": false,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Create Deal"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xffeff9f8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Step 2 of 4",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 6,
                  ),
                  CustomText(
                    text: "Deliverables",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    bottom: 6,
                  ),
                  LinearProgressIndicator(
                    value: 0.50,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                    backgroundColor: AppColors.greyLight,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              child: Column(
                children: [
                  CustomText(
                    text: "Define what the influencer will create for your brand",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textClr,
                    maxLines: 2,
                    bottom: 6,
                    textAlign: TextAlign.start,
                  ),



              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Platform(s)",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  /// PLATFORM BUTTONS
                  Row(
                    children: platforms.map((p) {
                      final bool active = p["name"] == selectedPlatform;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPlatform = p["name"];
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: active
                                  ? Colors.teal.shade200
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: active
                                    ? Colors.teal
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(p["icon"], color: p["color"], size: 30),
                                const SizedBox(height: 6),
                                Text(
                                  p["name"],
                                  style: TextStyle(
                                    fontWeight:
                                    active ? FontWeight.bold : FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  /// CONTENT TYPE CARDS
                  Column(
                    children: contentTypes.map((ct) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(ct["icon"], color: Colors.blue, size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ct["title"],
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ct["subtitle"],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: ct["selected"],
                              onChanged: (value) {
                                setState(() => ct["selected"] = value);
                              },
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  /// POST COUNT STEPPER
                  const Text(
                    "Post Count",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (postCount > 1) postCount--;
                            });
                          },
                          child: _stepButton("-"),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "$postCount",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() => postCount++);
                          },
                          child: _stepButton("+"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

                  SizedBox(height: 50,),
                  CustomButtonTwo(onTap: (){
                    Get.toNamed(AppRoutes.hostCreateDealThreeScreen);
                  },title: "Next →",)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _stepButton(String text) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
