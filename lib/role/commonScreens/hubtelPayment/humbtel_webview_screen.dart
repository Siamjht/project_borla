
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/helpers/prefs_helper.dart';
import 'package:project_borla/theme/gradient_scaffold_copy.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../components/customSnackbar/custom_snackbar.dart';
import '../../components/gradient_scafold.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/text/common_text.dart';

class HumbtelWebViewScreen extends StatefulWidget {
  final String url;
  const HumbtelWebViewScreen({super.key, required this.url});

  @override
  State<HumbtelWebViewScreen> createState() => _HumbtelWebViewScreenState();
}

class _HumbtelWebViewScreenState extends State<HumbtelWebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  final paymentCtrl = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            final String url = request.url;
            
            // Check for success URL
            if (url.startsWith('https://api.borlaborla.com/booking/success')) {
              CustomSnackbar.success('Payment Successful');
              paymentCtrl.isHubtelPaySuccess.value = true;
              Future.delayed(Duration(milliseconds: 300), () {
                Get.back(result: 'success');
              },);
              return NavigationDecision.prevent;
            }
            
            // Check for failed URL
            if (url.startsWith('https://api.borlaborla.com/booking/failed')) {
              Get.back(result: 'failed');
              CustomSnackbar.error('Payment Failed');
              return NavigationDecision.prevent;
            }
            
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    if(PrefsHelper.myRole == "rider"){
      return GradientScaffold(
        child: _buildSafeArea(),
      );
    }else{
      return UserGradientScaffold(
        child: _buildSafeArea(),
      );
    }
  }

  SafeArea _buildSafeArea() {
    return SafeArea(
      child: Column(
        children: [
          // ── Header ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CommonBackButton(),
                const CommonText(
                  text: 'Payment',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(width: 30),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // ── WebView ─────────────────────────────────
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _controller),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
