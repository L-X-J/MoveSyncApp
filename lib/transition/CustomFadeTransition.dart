import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// # [FadeTransition]
///
/// - author：`cxl`
/// - date: `2024-05-24 14:06
class CustomFadeTransition extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
