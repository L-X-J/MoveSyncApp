import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ActionPage extends StatelessWidget {
  ActionPage({Key? key}) : super(key: key);
  final logic = Get.put(ActionLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}