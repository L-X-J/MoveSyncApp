import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MinePage extends StatelessWidget {
  MinePage({Key? key}) : super(key: key);
  final logic = Get.put(MineLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}