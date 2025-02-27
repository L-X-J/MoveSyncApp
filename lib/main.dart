import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ms/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "慕动",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
