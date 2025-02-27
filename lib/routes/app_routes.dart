part of 'app_pages.dart';

///  APP 路由
///  author：cxl
///  date: 2023/6/15
class AppRoutes {
  AppRoutes._();

  /// 初始化
  static const init = _Paths.init;

  /// 主页
  static const main = _Paths.main;

  /// 登录注册
  static const login = _Paths.login;

  /// 主页动态
  static const mainPosts = main + _Paths.mainPosts;

  /// 主页运动
  static const mainAction = main + _Paths.mainAction;

  /// 主页我的
  static const mainMine = main + _Paths.mainMine;

  /// 用户详情(个人主页)
  static const detailsUser = _Paths.detailsUser;

  /// 动态详情
  static const detailsPosts = _Paths.detailsPosts;

  /// ---- 一些公共页
  static const webPage = _Paths.webPage;
}

abstract class _Paths {
  static const main = "/main";

  static const init = "/";

  /// 登录注册
  static const login = "/login";

  /// 主页动态
  static const mainPosts = "/posts";

  /// 主页运动
  static const mainAction = "/action";

  /// 主页我的
  static const mainMine = "/mine";

  /// 详情页
  static const _details = "/details";

  /// 用户详情(个人主页)
  static const detailsUser = "$_details/user";

  /// 动态详情
  static const detailsPosts = "$_details/posts";

  /// ---- 一些公共页
  /// 网页
  static const webPage = "/WebPage";
}
