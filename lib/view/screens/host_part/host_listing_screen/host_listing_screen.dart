import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text_field/custom_text_field.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_listing_screen/widgets/listin_custom_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_url.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/listing_controller.dart';

class HostListingScreen extends StatelessWidget {
  HostListingScreen({super.key});

  final ListingController controller = Get.put(ListingController());
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getListings(loadMore: false);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {controller.getListings(loadMore: true);}
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "My Listings"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomTextField(
              isDens: true,
              fillColor: const Color(0xffF5F5F5),
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.textClr),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 18,
                color: AppColors.textClr,
              ),
              onChanged: (value) {

              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.isListingLoading.value && controller.listingList.isEmpty) {return  Center(child: CustomLoader());}

                if (controller.listingList.isEmpty) {
                  return Center(child: CustomText(text: "No listings found", fontSize: 16,),);
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: controller.listingList.length + (controller.isLoadMoreLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < controller.listingList.length) {
                      final listing = controller.listingList[index];
                      return ListingCard(
                        listing: listing,
                        onTapAirbnb: () async {
                          final link = listing.addAirbnbLink;

                          if (  link.isEmpty) return;

                          final Uri uri = Uri.parse(
                            link.startsWith('http') ? link : 'https://$link',
                          );

                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        },


                      );
                    }
                    // Show load more loader
                    else {
                      return const Padding(padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CustomLoader()),
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.hostAddNewListingScreen);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
