import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DetailUserPage extends StatelessWidget {
  DetailUserPage({Key? key}) : super(key: key);
  final logic = Get.put(DetailUserLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}