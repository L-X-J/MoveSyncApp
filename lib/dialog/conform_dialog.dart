import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ms/themes/themes.dart';

///  这里写文件描述
///  author：cxl
///  date: 2023/6/8
const _pageTAG = "_ConformPage";

Future<bool?> showConformDialog(String content,{String? confirmText,String? cancelText,TextAlign? textAlign}) {
  return SmartDialog.show(builder: (context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.5).copyWith(bottom: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18,vertical: 20),
            child: Text(
              content,
              style: fontMedium.copyWith(
                  fontSize: 16,
                  color: Colors.black),
              textAlign: textAlign,
            ),
          ),
          Container(width: double.infinity,height: 0.5,color: AppThemes.instance.lineColor,),
          SizedBox(
            height: 54,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () {
                        SmartDialog.dismiss(tag: _pageTAG,result: false);
                      },
                      child: Text(
                        cancelText??"取消",
                        style: fontMedium.copyWith(
                          fontSize: 16,
                          color: AppColors.color99,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Container(
                  width: 0.5,
                  height: 36,
                  color: AppColors.colorCA,
                ),
                Expanded(
                    child: InkWell(
                      onTap: () {
                        SmartDialog.dismiss(tag: _pageTAG,result: true);
                      },
                      child: Text(
                        confirmText?? "确定",
                        style: fontMedium.copyWith(
                          fontSize: 16,
                          color: AppThemes.instance.primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  },clickMaskDismiss: false,tag: _pageTAG);
}
