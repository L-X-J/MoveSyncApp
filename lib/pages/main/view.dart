import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms/routes/app_pages.dart';

import 'logic.dart';

class MainView extends GetView<MainLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MainView'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('MainView is working', style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.login);
              },
              child: Text('Go to LoginView'),
            ),
          ],
        ),
      ),
    );
  }
}
