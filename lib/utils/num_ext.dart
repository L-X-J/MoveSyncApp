part of 'utils.dart';
extension NumExtension on num{

  /// 通用转字符串
  /// 如果是 11.2 则返回 11.2 如果是 11.28 则返回 11.28，如果是 11.00 则返回 11
  /// 如果是 11.10 则返回 11.1
  String get str {
    String str = toString();
    if (str.contains('.')) {
      str = str.replaceAll(RegExp(r'0*$'), ''); // Remove trailing zeros
      str = str.replaceAll(RegExp(r'\.$'), ''); // Remove trailing dot if any
    }
    return str;
  }
}