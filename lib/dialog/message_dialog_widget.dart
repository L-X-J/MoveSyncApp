import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:ms/themes/themes.dart';

const _pageTag = "_MessageDialogPage";

class _MessageDialogPage extends StatelessWidget {
  final String? title;
  final String message;
  final String? closeText;
  final String? confirmText;
  final bool noCloseButton;
  final GestureTapCallback? onClose;
  final GestureTapCallback? onConfirm;

  const _MessageDialogPage({
    this.title,
    required this.message,
    this.closeText,
    this.noCloseButton = false,
    this.confirmText,
    this.onClose,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 6),
          title == null
              ? Container()
              : Text("重要提示", style: context.theme.textTheme.titleLarge),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 21,
            ).copyWith(bottom: 29),
            child: Text(message, style: context.theme.textTheme.bodyMedium),
          ),
          Row(
            children: [
              if (!noCloseButton)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      SmartDialog.dismiss(tag: _pageTag, result: false);
                      onClose?.call();
                    },
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF888888),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      alignment: Alignment.center,
                      child: Text(closeText ?? "关闭"),
                    ),
                  ),
                ),
              if (!noCloseButton) SizedBox(width: 20),
              Expanded(
                child: InkWell(
                  onTap: () {
                    SmartDialog.dismiss(tag: _pageTag, result: true);
                    onConfirm?.call();
                  },
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        colors: [
                          context.theme.primaryColorDark,
                          context.theme.primaryColor,
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      confirmText ?? "确定",
                      style: fontSemiBold.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool?> showMessageDialog({
  String? title,
  required String message,
  String? closeText,
  String? confirmText,
  bool noCloseButton = false,
  GestureTapCallback? onClose,
  GestureTapCallback? onConfirm,
}) {
  return SmartDialog.show(
    builder:
        (context) => _MessageDialogPage(
          title: title,
          message: message,
          closeText: closeText,
          confirmText: confirmText,
          noCloseButton: noCloseButton,
          onClose: onClose,
          onConfirm: onConfirm,
        ),
    tag: _pageTag,
  );
}
