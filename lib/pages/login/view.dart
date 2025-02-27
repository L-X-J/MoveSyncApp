import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Your Ui')));
  }
}
