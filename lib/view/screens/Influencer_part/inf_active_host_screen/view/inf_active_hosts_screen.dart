import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../../../../components/custom_text_field/custom_text_field.dart';
import '../controller/inf_active_host_controller.dart';
import '../widget/host_active_card.dart';

class InfActiveHostsScreen extends StatelessWidget {
  InfActiveHostsScreen({super.key});
  final InfActiveHostController influencerListHostController = Get.put(InfActiveHostController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      influencerListHostController.getActiveHost();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Active Host"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(
                isDens: true,
                fillColor: const Color(0xffF5F5F5),
                fieldBorderColor: AppColors.primary2,
                hintText: "Search Host by Name ",
                hintStyle: TextStyle(color: AppColors.textClr),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textClr),
                onChanged: (value) {
                  influencerListHostController.searchQuery.value = value;
                  if (value.trim().isEmpty) {
                    influencerListHostController.searchHostList.clear();
                    influencerListHostController.setSearchHostStatus(Status.completed);
                  } else {
                    influencerListHostController.searchHost(query: value);
                  }
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final bool isSearching = influencerListHostController.searchQuery.value.isNotEmpty;

                  if (!isSearching && influencerListHostController.rxStatus.value == Status.loading) {
                    return  Center(child: CustomLoader());
                  }

                  if (isSearching && influencerListHostController.rxSearchHostStatus.value == Status.loading) {
                    return  Center(child: CustomLoader());
                  }

                  final listToShow = isSearching ? influencerListHostController.searchHostList : influencerListHostController.hostList;

                  if (listToShow.isEmpty) {
                    return const Center(child: Text("No influencers found"),
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!isSearching && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !influencerListHostController.isLoadMore.value) {
                        influencerListHostController.getActiveHost(loadMore: true);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: listToShow.length + (!isSearching && influencerListHostController.isLoadMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (!isSearching && index == listToShow.length) {
                          return  Padding(padding: EdgeInsets.all(12),
                            child: Center(child: CustomLoader()),
                          );
                        }

                        final user = listToShow[index];

                        return CustomHostActiveCard(
                          userName: user.name,
                          userHandle: user.userName ?? '',
                          location: user.fullAddress,
                          profileImage: (user.image != null && user.image!.isNotEmpty) ? ApiUrl.baseUrl + user.image! : AppConstants.profileImage2 ,
                          // on: () {
                          //   Get.toNamed(AppRoutes.chatScreen,
                          //     arguments: {
                          //       'conversationId':"", //conversation.id ?? " ",
                          //       'userName': user.name,
                          //       'userImage': user.image,
                          //       'receiverId': user.id,
                          //     },
                          //   );
                          // },
                          onViewDetailsTap: () {
                            debugPrint("user.userName, === ${user.image}");
                            debugPrint("user.isFounderMember === ${user.isFounderMember}");
                            Get.toNamed(AppRoutes.infActiveHostProfileScreen,
                              arguments: {
                                "id": user.id,
                                "name": user.name,
                                "userName": user.userName,
                                "image": user.image,
                                "founderMember": user.isFounderMember,
                                "location": user.fullAddress,
                              },
                            );
                          }, socialMediaLinks: [],
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
