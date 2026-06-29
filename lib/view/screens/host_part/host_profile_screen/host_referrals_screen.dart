import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/app_const/app_const.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_text/custom_text.dart';
import 'controller/host_profile_controller.dart';
import 'model/referal.dart';

class HostReferralsScreen extends StatelessWidget {
  HostReferralsScreen({super.key});
  final page = Get.arguments;
  final HostProfileController controller = Get.put(HostProfileController());

  void _handleCopy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFF8674),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                "Link copied to clipboard!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getReferralData();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Referrals",
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.rxReferralStatus.value == Status.loading) {
          return Center(child: CustomLoader(color: AppColors.primary2));
        }
        if (controller.rxReferralStatus.value == Status.error) {
          return const Center(
            child: CustomText(text: "Failed to load referral data"),
          );
        }

        final referralCode = controller.referralData.value?.referralCode ?? "";
        final referralLink = "https://app.example.com/join?ref=$referralCode";

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Referral Link Card
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Your Referral Link",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    const CustomText(
                      text: "Share this link to earn rewards",
                      fontSize: 13,
                      color: Colors.grey,
                      top: 4,
                      bottom: 12,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        referralLink,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleCopy(context, referralLink),
                        icon: const Icon(
                          Icons.copy,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Copy Link",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: page == "host"
                              ? AppColors.primary
                              : AppColors.primary2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // QR Code Card
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "QR Code",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      bottom: 12,
                    ),
                    Center(
                      child: QrImageView(
                        data: referralLink,
                        version: QrVersions.auto,
                        size: 180.0,
                      ),
                    ),
                  ],
                ),
              ),

              // Your Stats Section
              const CustomText(
                text: "Your Stats",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                top: 24,
                bottom: 12,
              ),
              _buildStatTile(
                "Total Referrals",
                "${controller.referralData.value?.referralCount ?? 0}",
                Icons.people_outline,
                const Color(0xFFE0E7FF),
                const Color(0xFF4F46E5),
              ),

              // Recent Referrals Section
              const CustomText(
                text: "Recent Referrals",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                top: 24,
                bottom: 12,
              ),
              referredUsersList(
                controller.referralData.value?.referredUsers ?? [],
              ),
            ],
          ),
        );
      }),
    );
  }

  // Card Helper
  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: child,
    );
  }

  // Stat Tile Helper
  Widget _buildStatTile(
    String title,
    String count,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          CustomText(text: title, fontWeight: FontWeight.w500, fontSize: 14),
          const Spacer(),
          CustomText(text: count, fontWeight: FontWeight.bold, fontSize: 18),
        ],
      ),
    );
  }

  Widget referredUsersList(List<ReferralItem> users) {
    if (users.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: const CustomText(text: "No referrals yet", color: Colors.grey),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final user = users[index];
          final imageUrl = (user.pic != null && user.pic!.isNotEmpty)
              ? (user.pic!.startsWith("http")
                    ? user.pic!
                    : ApiUrl.baseUrl + user.pic!)
              : "https://via.placeholder.com/150";
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
            title: Text(
              user.name ?? "Unknown",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              user.date ?? "",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
