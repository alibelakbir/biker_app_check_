import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_theme.dart';
import '../utils/loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String appBarText;
  final String? geo;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.appBarText,
    this.geo,
  });
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoaded = false;
  bool showErrorPage = false;
  late WebViewControllerPlus controller;

  @override
  void initState() {
    log(widget.url);
    super.initState();
    debugPrint(widget.url);

    controller =
        WebViewControllerPlus()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..clearCache()
          ..setUserAgent(
            'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Mobile Safari/537.36',
          )
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {
                setState(() {
                  isLoaded = false;
                  showErrorPage = false;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoaded = true;
                });
              },
              onWebResourceError: (WebResourceError error) {
                // Ignore subresource errors (common with WebView) and only show error page if main frame fails
                // Also ignore transient -1 net::ERR_FILE_NOT_FOUND that often occurs for subresources
                final isMainFrame = error.isForMainFrame ?? false;
                final code = error.errorCode;
                debugPrint(
                  'WebView error code=$code mainFrame=$isMainFrame type=${error.errorType} desc=${error.description}',
                );
                if (!isMainFrame) return;
                if (code == -1) return;
                setState(() {
                  showErrorPage = true;
                });
              },
              onNavigationRequest: (NavigationRequest request) {
                // Allow standard http/https navigations (needed for Google Forms redirects)
                final uri = Uri.parse(request.url);
                if (uri.scheme == 'http' || uri.scheme == 'https') {
                  return NavigationDecision.navigate;
                }
                return NavigationDecision.prevent;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.appBarText,
          style: AppTextStyles.base.s14.w600.whiteColor,
        ),
      ),
      body: Stack(
        children: [
          showErrorPage
              ? InkWell(
                onTap: () {
                  setState(() {
                    isLoaded = false;
                    showErrorPage = false;
                  });
                  controller.loadRequest(Uri.parse(widget.url));
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icon/empty-data.svg',
                        height: 72,
                      ),

                      const SizedBox(height: 20),
                      Text('check_your_internet_connection'.tr()),
                    ],
                  ),
                ),
              )
              : WebViewWidget(controller: controller),
          (isLoaded) ? const SizedBox() : Center(child: Loading()),
        ],
      ),
    );
  }
}
