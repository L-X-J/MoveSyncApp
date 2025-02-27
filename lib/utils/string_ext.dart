part of 'utils.dart';
extension StringExt on String {
  /// 安全的转换为int 转换失败时返回[error]
  int toSelfInt({int error = 0}) {
    try {
      return int.tryParse(this) ?? error;
    } catch (e) {
      return error;
    }
  }

  /// 安全的转换为int 转换失败时返回[error]
  double toSelfDouble({double error = 0}) {
    try {
      return double.tryParse(this) ?? error;
    } catch (e) {
      return error;
    }
  }

  String get assetsImg => "assets/images/$this.png";
  String get assetsPng => "assets/images/$this.png";
  String get assetsSvg => "assets/images/$this.svg";
  String get assetsLottie => "assets/lottie/$this.json";
  String get images => "assets/images/$this";
  String get lottie => "assets/lottie/$this.json";

  Color toColor() {
    // 去除字符串中的'#'字符
    String hexColor = replaceAll('#', '');
    // 判断处理后的字符串长度，以适配不同格式
    if (hexColor.length == 6) {
      // 如果是6位长度，表示不包含透明度，需要在前面加上FF表示不透明
      hexColor = 'FF$hexColor';
    }
    // 将处理好的字符串转换为16进制数值，并创建Color对象
    return Color(int.parse(hexColor, radix: 16));
  }

  /// 判断字符串是否是json
  bool isJson(){
    try {
      jsonDecode(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}
