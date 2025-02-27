import 'package:get/get.dart';
import 'package:ms/pages/pages.dart';
import 'package:ms/transition/CustomFadeTransition.dart';

part 'app_routes.dart';

///  页面们
///  author：cxl
///  date: 2023/6/15
class AppPages {
  AppPages._();

  static var initial = _Paths.main;
  static final routes = [
    GetPage(
      title: "主页",
      name: _Paths.main,
      page: () => MainView(),
      children: [
        GetPage(title: "动态", name: _Paths.mainPosts, page: () => PostsPage()),
        GetPage(title: "运动", name: _Paths.mainAction, page: () => ActionPage()),
        GetPage(title: "我的", name: _Paths.mainMine, page: () => MinePage()),
      ],
    ),
    GetPage(
      title: "用户详情",
      name: _Paths.detailsUser,
      page: () => DetailUserPage(),
    ),
    GetPage(
      title: "动态详情",
      name: _Paths.detailsPosts,
      page: () => DetailPostsPage(),
    ),
    GetPage(
      title: "web页面",
      name: _Paths.webPage,
      page: () => WebPage(),
    ),
    GetPage(
      title: "登录&注册",
      name: _Paths.login,
      transition: Transition.downToUp,
      page: () => LoginPage(),
    ),
  ];
}
