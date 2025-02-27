import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms/routes/app_pages.dart';

import 'logic.dart';


/// web页面参数
class WebPageArguments {
  /// 标题
  final String? title;

  /// url
  final String url;

  /// 是否是Asset文件
  final bool isAsset;

  WebPageArguments({this.title, required this.url, this.isAsset = false});

  factory WebPageArguments.fromJson(Map<String, dynamic> json) {
    return WebPageArguments(
      title: json['title'],
      url: json['url'],
      isAsset: json['isAsset'],
    );
  }
}

Future<T?>? jumpToWebPage<T>(WebPageArguments arguments) {
  return Get.toNamed(AppRoutes.webPage, arguments: arguments);
}

Future<T?>? jumpToWebPage2<T>(String url,
    {String? title, bool isAsset = false}) {
  return jumpToWebPage(
      WebPageArguments(url: url, title: title, isAsset: isAsset));
}


/// 网页
class WebPage extends StatelessWidget {
  WebPage({Key? key}) : super(key: key);
  final logic = Get.put(WebLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}