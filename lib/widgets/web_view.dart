import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://baotainguyenmoitruong.vn/da-nang-trien-khai-luat-bao-ve-moi-truong-cho-cac-doanh-nghiep-khu-cong-nghiep-363363.html'));
class WebViewPage extends StatelessWidget {
  //final String url;

  const WebViewPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thu Gom App'),
      ),
      body: WebViewWidget(
          controller: controller,

      ),
    );
  }
}


