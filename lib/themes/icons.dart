part of 'themes.dart';

/// App的一些共用图标
abstract class AppIcons{

  /// 返回图标
  static const backIcon = Icon(
    Icons.arrow_back_ios,
  );

  /// item 前进
  static const arrowRight = Icon(
    Icons.keyboard_arrow_right,
    size: 22,
    color: AppColors.colorBE
  );
  /// item 前进
  static const arrowDown = Icon(
    Icons.keyboard_arrow_down,
    size: 22,
    color: AppColors.colorBE
  );

  static const dialogClose = Icon(
    Icons.close,
    size: 20,
    color: AppColors.colorA0,
  );

}