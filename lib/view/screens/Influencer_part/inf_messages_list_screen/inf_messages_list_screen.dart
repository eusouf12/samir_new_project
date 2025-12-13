import 'package:flutter/material.dart';
import 'package:samir_flutter_app/utils/app_colors/app_colors.dart';
import 'package:samir_flutter_app/utils/app_const/app_const.dart';
import 'package:samir_flutter_app/utils/app_icons/app_icons.dart';
import 'package:samir_flutter_app/view/components/custom_image/custom_image.dart';
import 'package:samir_flutter_app/view/components/custom_nav_bar/vendor_navbar.dart';
import 'package:samir_flutter_app/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:samir_flutter_app/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:samir_flutter_app/view/components/custom_text/custom_text.dart';
import 'package:samir_flutter_app/view/screens/host_part/host_messages_list_screen/widgets/custom_message_card.dart';

import '../../../components/custom_nav_bar/navbar.dart';

class InfMessagesListScreen extends StatelessWidget {
  const InfMessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Messages"),
      body: ListView(
        children: List.generate(10, (value){return CustomMessageCard();})
      ),
      bottomNavigationBar: InfNavbar(currentIndex: 2),
    );
  }
}
