import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_loader/custom_loader.dart';

class StripeWebViewScreen extends StatefulWidget {
  final String onboardingUrl;

  const StripeWebViewScreen({super.key, required this.onboardingUrl});

  @override
  State<StripeWebViewScreen> createState() => _StripeWebViewScreenState();
}

class _StripeWebViewScreenState extends State<StripeWebViewScreen> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition (important for Android)
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.onboardingUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: BackButton(onPressed: (){
          Get.back();
        },
            color: AppColors.black
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
             Center(child: CustomLoader(),
            ),
        ],
      ),
    );
  }
}