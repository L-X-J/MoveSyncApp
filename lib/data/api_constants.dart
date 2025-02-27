part of 'constants.dart';

///
/// # [api_constants]
/// 
/// - author：`cxl`
/// - date: `2024-03-27 14:52
class ApiConstants {
  ApiConstants._();

  /// 默认分页大小
  static const int defaultPageSize = 20;

  static const int intFalse = 0;

  static const int intTrue = 1;

  static const String strFalse = "0";

  static const String strTrue = "1";
}

class ApiUrlConstants{
  /// 获取项目列表
  ApiUrlConstants._();
  /// 获取项目列表
  static const projectList = "/ci/approve/project";
  /// 获取关联备用金列表
  static const lendList= "/ci/approve/lend";
}