import 'package:flutter/material.dart';

class StatusTaskCard extends StatelessWidget {
  final String title;
  final bool isSubmitted;

  const StatusTaskCard({
    super.key,
    required this.title,
    required this.isSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSubmitted ? const Color(0xFFE8F9F1) : Colors.grey.shade200;
    Color iconBoxColor = isSubmitted ? const Color(0xFFAEF1D1) : Colors.grey.shade300;
    Color themeColor = isSubmitted ? const Color(0xFF0F723A) : Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A),),),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(isSubmitted ? Icons.check : Icons.access_time, size: 14, color: themeColor,),
                    const SizedBox(width: 4),
                    Text(
                      isSubmitted ? "Submitted" : "In Progress",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: themeColor,),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}