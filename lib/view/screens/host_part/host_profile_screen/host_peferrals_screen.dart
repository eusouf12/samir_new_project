import 'package:flutter/material.dart';

import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
class HostPeferralsScreen extends StatelessWidget {
  const HostPeferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Referrals"),
    );
  }
}
