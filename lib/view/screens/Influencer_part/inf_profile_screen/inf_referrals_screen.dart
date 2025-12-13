import 'package:flutter/material.dart';

import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';
class InfReferralsScreen extends StatelessWidget {
  const InfReferralsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Referrals"),
    );
  }
}
