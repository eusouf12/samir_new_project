import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_text/custom_text.dart';

class InfReferralsScreen extends StatelessWidget {
  const InfReferralsScreen({super.key});

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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
    const String referralLink = "https://app.example.com/join?ref=_JH6K82X";

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
          style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Referral Link Card
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Your Referral Link", fontWeight: FontWeight.bold, fontSize: 16),
                  const CustomText(text: "Share this link to earn rewards", fontSize: 13, color: Colors.grey, top: 4, bottom: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(8)),
                    child: const Text(referralLink, style: TextStyle(color: Colors.blue, fontSize: 13)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () => _handleCopy(context, referralLink),
                      icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                      label: const Text("Copy Link", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8674),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  const CustomText(text: "QR Code", fontWeight: FontWeight.bold, fontSize: 16, bottom: 12),
                  Center(
                    child: QrImageView(data: referralLink, version: QrVersions.auto, size: 180.0),
                  ),
                ],
              ),
            ),

            // Your Stats Section
            const CustomText(text: "Your Stats", fontSize: 18, fontWeight: FontWeight.bold, top: 24, bottom: 12),
            _buildStatTile("Total Referrals", "24", Icons.people_outline, const Color(0xFFE0E7FF), const Color(0xFF4F46E5)),
            _buildStatTile("Successful Sign-ups", "18", Icons.person_add_alt_1_outlined, const Color(0xFFDCFCE7), const Color(0xFF16A34A)),

            // Recent Referrals Section
            const CustomText(text: "Recent Referrals", fontSize: 18, fontWeight: FontWeight.bold, top: 24, bottom: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                    ),
                    title: const Text("User Name", style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text("Nov 15, 2024", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
  Widget _buildStatTile(String title, String count, IconData icon, Color bgColor, Color iconColor) {
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
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
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
}