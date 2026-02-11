import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/view/components/custom_gradient/custom_gradient.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text_field/custom_text_field.dart';
import '../host_listing_screen/widgets/custom_active_card.dart';
import '../host_messages_list_screen/controller/chat_list_controller.dart';
import 'controller/influencer_list_host_controller.dart';

class HostActiveInflue extends StatelessWidget {
  HostActiveInflue({super.key});
  final InfluencerListHostController influencerListHostController = Get.put(InfluencerListHostController());
  final ChatListController chatListController = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      influencerListHostController.getInfluencers();
    });
    return CustomGradient(
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Active Influencers"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextField(
                isDens: true,
                fillColor: const Color(0xffF5F5F5),
                hintText: "Search influencer by name ",
                hintStyle: TextStyle(color: AppColors.textClr),
                prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.textClr),
                onChanged: (value) {
                  influencerListHostController.searchQuery.value = value;

                  if (value.trim().isEmpty) {
                    influencerListHostController.searchInfluencerList.clear();
                    influencerListHostController.setSearchInfluencerStatus(Status.completed);
                  } else {
                    influencerListHostController.searchInfluencer(query: value);
                  }
                },
              ),
              SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  final bool isSearching = influencerListHostController.searchQuery.value.isNotEmpty;

                  if (!isSearching && influencerListHostController.rxStatus.value == Status.loading) {
                    return const Center(child: CustomLoader());
                  }

                  if (isSearching && influencerListHostController.rxSearchInfluencerStatus.value == Status.loading) {
                    return const Center(child: CustomLoader());
                  }

                  final listToShow = isSearching ? influencerListHostController.searchInfluencerList : influencerListHostController.influencerList;

                  if (listToShow.isEmpty) {
                    return const Center(child: Text("No influencers found"),
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!isSearching && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !influencerListHostController.isLoadMore.value) {
                        influencerListHostController.getInfluencers(loadMore: true);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: listToShow.length + (!isSearching && influencerListHostController.isLoadMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (!isSearching && index == listToShow.length) {
                          return const Padding(padding: EdgeInsets.all(12),
                            child: Center(child: CustomLoader()),
                          );
                        }

                        final user = listToShow[index];

                        return CustomActiveCard(
                          name: user.name,
                           nightCredits: user.nightCredits,
                          username: user.userName ?? '',
                          socialMediaLinks: user.socialMediaLinks,
                          imageUrl: (user.image != null && user.image!.isNotEmpty) ? ApiUrl.baseUrl + user.image! : AppConstants.profileImage2 ,
                          onViewMessage: () async {
                            final conversationId = await chatListController.checkChatListExist(id: user.id);

                              Get.toNamed(AppRoutes.chatScreen,
                                arguments: {
                                  'conversationId':conversationId != null ? conversationId : "",
                                  'userName': user.name,
                                  'userImage': user.image,
                                  'receiverId': user.id,
                                },
                              );
                          },
                          onViewProfile: () {
                            debugPrint("user.userName, === ${user.image}");
                            debugPrint("user.isFounderMember === ${user.isFounderMember}");
                            Get.toNamed(AppRoutes.hostActiveViewProfileScreen,
                              arguments: {
                                "id": user.id,
                                "name": user.name,
                                "userName": user.userName,
                                "image": user.image,
                                "socialMediaLinks": user.socialMediaLinks.map((e) => {
                                  "platform": e.platform,
                                  "url": e.url,
                                  "followers": e.followers,
                                  "_id": e.id,
                                }).toList(),
                                "founderMember": user.isFounderMember,
                                "nightCredits": user.nightCredits,
                              },
                            );
                          },
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
