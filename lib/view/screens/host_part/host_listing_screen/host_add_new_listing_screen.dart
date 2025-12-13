import 'package:flutter/material.dart';
import 'package:samir_flutter_app/view/components/custom_button/custom_button_two.dart';
import 'package:samir_flutter_app/view/components/custom_from_card/custom_from_card.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';

class HostAddNewListingScreen extends StatefulWidget {
  const HostAddNewListingScreen({super.key});

  @override
  State<HostAddNewListingScreen> createState() => _HostAddNewListingScreenState();
}

class _HostAddNewListingScreenState extends State<HostAddNewListingScreen> {

  final Map<String, bool> amenities = {
    "Wi-Fi": false,
    "Parking": false,
    "AC": false,
    "Pool": false,
    "TV": false,
    "Kitchen": false,
    "Pet Friendly": false,
  };

  final Map<String, IconData> icons = {
    "Wi-Fi": Icons.wifi,
    "Parking": Icons.directions_car,
    "AC": Icons.ac_unit,
    "Pool": Icons.pool,
    "TV": Icons.tv,
    "Kitchen": Icons.kitchen,
    "Pet Friendly": Icons.pets,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Add New Listing"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomFormCard(
                title: "Listing Tittle",
                hintText: "Dhaka",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Description",
                maxLine: 3,
                hintText: "Describe your property, nearby, attractions, and key details…",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Location",
                hintText: "Dhaka",
                prefixIcon: Icon(Icons.location_on,color: AppColors.textClr,),
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Airbnb Link",
                hintText: "Dhaka",
                prefixIcon: Icon(Icons.link,color: AppColors.red,),
                controller: TextEditingController(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Photos Section
                  Text(
                    "Photos",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 12),
          
                  _photoUploadBox(),
          
                  const SizedBox(height: 28),
          
                  /// Amenities Section
                  Text(
                    "Amenities",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 16),
          
                  _amenitiesGrid(),
          
                  const SizedBox(height: 30),
          
                  /// Save Button
                 CustomButtonTwo(onTap: (){},title: "Save Listing",),
                  SizedBox(height: 50,),
                ],
              ),
          
            ],
          ),
        ),
      ),
    );
  }


  /////=========================
  /// Photo Upload Box
  /// ------------------------------
  Widget _photoUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined,
              size: 40, color: Colors.grey.shade500),
          const SizedBox(height: 10),
          Text(
            "Upload property photos\nPNG, JPG up to 10MB",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {},
            child: Text(
              "Choose Files",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  /// ------------------------------
  /// Amenities Grid
  /// ------------------------------
  Widget _amenitiesGrid() {
    return Column(
      children: [
        _row(["Wi-Fi", "Parking"]),
        _row(["AC", "Pool"]),
        _row(["TV", "Kitchen"]),
        _row(["Pet Friendly"]),
      ],
    );
  }

  Widget _row(List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: items
            .map(
              (name) => Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                Border.all(color: Colors.grey.shade300, width: 1),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: amenities[name],
                    onChanged: (value) {
                      setState(() {
                        amenities[name] = value ?? false;
                      });
                    },
                  ),
                  Icon(
                    icons[name],
                    color: const Color(0xff2979FF),
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
