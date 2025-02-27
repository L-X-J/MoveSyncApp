import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PostsPage extends StatelessWidget {
  PostsPage({Key? key}) : super(key: key);
  final logic = Get.put(PostsLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Your Ui'),
      ),
    );
  }
}