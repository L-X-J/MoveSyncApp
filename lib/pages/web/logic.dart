import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ms/pages/web/view.dart';
import 'package:ms/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

/// 网页
class WebLogic extends GetxController {
  
  final showProgress = false.obs;
  
  late final WebViewController webViewController;
  final showAppBar = true.obs;
  late final WebPageArguments arguments;
  late final PlatformWebViewControllerCreationParams params;



  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is WebPageArguments) {
      arguments = Get.arguments as WebPageArguments;
    } else {
      EasyLoading.showToast("ARGUMENTS IS ABNORMAL");
      Get.back();
      return;
    }
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true);
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      params = AndroidWebViewControllerCreationParams();
    }
    Log.d("TITLE->${arguments.title}\nURL  -> ${arguments.url}");
    webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          if (progress > 98) {
            showProgress.value = false;
          } else {
            showProgress.value = true;
          }
        },
        onPageStarted: (String url) {
          showProgress.value = true;
        },
        onPageFinished: (String url) {
          showProgress.value = false;
        },
        onWebResourceError: (WebResourceError error) {
          Log.d("onWebResourceError-->${error.description}");
        },
        onHttpAuthRequest: (request) {
          Log.d("onHttpAuthRequest-->${request.host}, ${request.realm}");
        },
        onHttpError: (error) {
          Log.d("onHttpError-->request:${error.request?.uri}");
          Log.d(
              "onHttpError-->response:${error.response?.uri}-->${error.response?.statusCode}");
        },
        onUrlChange: (change) {
          Log.d("onUrlChange-->${change.url}");
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ));
  }

  @override
  void onReady() async {
    super.onReady();
    if (arguments.isAsset) {
      webViewController.loadFlutterAsset(arguments.url);
    } else {
      webViewController.loadRequest(Uri.parse(arguments.url));
    }
  }
}