import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DetailPostsPage extends StatelessWidget {
  DetailPostsPage({Key? key}) : super(key: key);
  final logic = Get.put(DetailPostsLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}