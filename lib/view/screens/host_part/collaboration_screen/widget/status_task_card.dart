import 'package:flutter/material.dart';

import '../../../../../utils/app_colors/app_colors.dart';

class StatusTaskCard extends StatelessWidget {
  final String title;
  final String status;
  final bool isSubmitted;
  final VoidCallback onEditTap;

  const StatusTaskCard({
    super.key,
    required this.title,
    required this.status,
    required this.isSubmitted,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSubmitted ? AppColors.primary.withOpacity(0.1) : Colors.grey.shade200;
    Color iconBoxColor = isSubmitted ? AppColors.primary.withOpacity(0.1)  : Colors.grey.shade300;
    Color themeColor = isSubmitted ?AppColors.primary: Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBoxColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.camera_alt, color: themeColor, size: 20,),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A),),),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(isSubmitted ? Icons.check_circle : Icons.access_time, size: 14, color: themeColor,),
                    const SizedBox(width: 4),
                    Text(isSubmitted ? "Submitted" : "In Progress", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: themeColor,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isSubmitted ? const SizedBox.shrink() :
          (status == 'rejected' || status == 'pending' || status == 'accepted' || status == 'negotiating') ? SizedBox.shrink()
          : IconButton(onPressed: onEditTap, icon: Icon(Icons.cloud_upload, color: themeColor),
          ),
        ],
      ),
    );
  }
}