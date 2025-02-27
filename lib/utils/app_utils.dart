
part of 'utils.dart';
class AppUtils{

  AppUtils._();

  static bool isPhone(String phone){
    RegExp exp = RegExp(r"^((09)|9)\d{9}$");
    bool matched = exp.hasMatch(phone);
    return matched;
  }

  /// 验证密码是否合法
  static bool isPwd(String? pwd){
    return pwd !=null && pwd.isNotEmpty && pwd.length >= 6;
  }

  static bool isEmail(String email){
    RegExp exp = RegExp("^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$");
    bool matched = exp.hasMatch(email);
    return matched;
  }

  static String doubleToString(double? value){
    return double.parse(value.toString()).toString();
  }

  static String doubleToMoney(num? value){
    return double.parse(value.toString()).toStringAsFixed(2);
  }
  static String stringToMoney(String value){
    if(value.isNotEmpty){
      return doubleToMoney(double.parse(value));
    }else {
      return "0";
    }
  }

}