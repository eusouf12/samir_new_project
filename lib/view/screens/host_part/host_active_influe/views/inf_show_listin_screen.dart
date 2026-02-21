import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_listing_screen/widgets/listin_custom_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../../host_listing_screen/controller/listing_controller.dart';


class InfShowListingScreen extends StatelessWidget {
  InfShowListingScreen({super.key});

  final ListingController controller = Get.put(ListingController());
  final userId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getListings(loadMore: false,hostById: userId);
    });


    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "All Listings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [

            Expanded(
              child: Obx(() {
                if (controller.rxListingStatus.value == Status.loading) {
                  return  Center(child: CustomLoader());
                }
                final listToShow =  controller.listingList;

                if (listToShow.isEmpty) {
                  return const Center(
                    child: CustomText(text: "No listings found", fontSize: 16),
                  );
                }

                return
                  ListView.builder(
                    itemCount: listToShow.length,
                    itemBuilder: (context, index) {
                      if (index < listToShow.length) {
                        final listing = listToShow[index];
                        return ListingCard(
                          listing: listing,
                          staus: listing.status,
                          btn: false,
                          btn2: true,
                          onTapAirbnb: () async {
                            final link = listing.addAirbnbLink;
                            if (link.isEmpty) return;

                            final uri = Uri.parse(link.startsWith('http') ? link : 'https://$link',);
                            await launchUrl(uri, mode: LaunchMode.externalApplication,);
                          },
                          onTapCollaboration: (){
                            //update this
                            Get.toNamed(AppRoutes.hostUpdateListingScreen,arguments: listing.id);
                          },
                        );
                      }
                      else {
                        return  Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CustomLoader(color: AppColors.primary2,)),
                        );
                      }
                    },
                  );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
