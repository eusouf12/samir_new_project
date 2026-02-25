import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../../core/app_routes/app_routes.dart';

class StripeWebViewCreateScreen extends StatefulWidget {
  final String checkoutUrl;

  const StripeWebViewCreateScreen({super.key, required this.checkoutUrl});

  @override
  State<StripeWebViewCreateScreen> createState() => _StripeWebViewCreateScreenState();
}

class _StripeWebViewCreateScreenState extends State<StripeWebViewCreateScreen> {
  final RxBool isLoading = true.obs;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // if (Platform.isIOS) {
    //   WebViewPlatform.instance = CupertinoWebViewPlatform();
    // }


    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint("Started URL: $url");

            if (url.contains("success")) {
              debugPrint(" Payment Success Redirect Detected");
              Get.offAllNamed(AppRoutes.hostCollaborationScreen);
            }

            if (url.contains("cancel")) {
              debugPrint(" Payment Cancelled by user");
              Get.back();
              Get.snackbar("Payment", "Payment cancelled by user");
            }
          },
          onPageFinished: (_) {
            isLoading.value = false;
          },
        ),
      )
      ..setUserAgent(
          "Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) "
              "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.0 Mobile/15E148 Safari/604.1"
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay with Stripe")),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Obx(() => isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
