part of 'themes.dart';

///  app的主题
///  author：cxl
///  date: 2023/6/15
class AppThemes {
  AppThemes._();

  static final AppThemes _instance = AppThemes._();

  static AppThemes get instance => _instance;

  static ThemeData get themeData => instance._themeData;

  /// 主页导航栏和底部导航栏的默认主题
  SystemUiOverlayStyle get mainSystemUiOverlayStyle =>
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
        statusBarColor: Colors.transparent,
      );

  static AppBar defaultAppBar(
    String title, {
    VoidCallback? onPressedBack,
    double? elevation,
    List<Widget>? actions,
    Widget? leading,
    Widget? titleWidget,
    Color backgroundColor = Colors.white,
    bool lightTheme = false,
    RxString? titleRX,
    PreferredSizeWidget? bottom,
  }) {
    return AppBar(
      title:
          titleWidget ??
          (titleRX != null
              ? Obx(
                () => Text(
                  titleRX.value,
                  style:
                      lightTheme
                          ? AppThemes.themeData.appBarTheme.titleTextStyle
                              ?.copyWith(color: Colors.white)
                          : null,
                  maxLines: 1,
                ),
              )
              : Text(
                title,
                style:
                    lightTheme
                        ? AppThemes.themeData.appBarTheme.titleTextStyle
                            ?.copyWith(color: Colors.white)
                        : null,
              )),
      iconTheme:
          lightTheme
              ? AppThemes.themeData.appBarTheme.iconTheme?.copyWith(
                color: Colors.white,
              )
              : null,
      centerTitle: true,
      actions: actions,
      elevation: elevation,
      bottom: bottom,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      leading:
          leading ??
          IconButton(
            onPressed:
                onPressedBack ??
                () {
                  Get.back();
                },
            icon: AppIcons.backIcon,
          ),
    );
  }

  Color get primaryColor => AppColors.colorEB5C20;

  Color get primaryColorLight => AppColors.colorFFAA85;

  Color get primaryColorDark => AppColors.colorE54400;

  Color get scaffoldBackgroundColor => AppColors.colorF5;

  Color get selectedTextColor => primaryColor;

  Color get unSelectedTextColor => AppColors.color99;

  Color get textColor => Colors.black;

  Color get textHintColor => AppColors.colorAF;

  Color get lineColor => AppColors.colorCA;

  TextStyle get inputTextHintStyle =>
      fontRegular.copyWith(fontSize: 14, color: textHintColor);

  TextStyle get inputTextStyle =>
      fontRegular.copyWith(fontSize: 15, color: textColor);

  TextStyle get subTitleTextStyle =>
      fontMedium.copyWith(fontSize: 15, color: Colors.black);

  TextStyle get dialogTitleTextStyle =>
      fontSemiBold.copyWith(fontSize: 16, color: Colors.black);

  ThemeData get _themeData => ThemeData(
    // 应用程序主要部分（工具栏、标签栏等）的背景颜色
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    dividerTheme: DividerThemeData(color: lineColor, thickness: 0.5),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      surface: scaffoldBackgroundColor,
      onPrimary: Colors.white,
    ),
    // 页面的背景颜色。
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(),
    appBarTheme: _buildAppBarTheme(),
    inputDecorationTheme: _buildInputDecorationTheme(),
    // buttonTheme: _buildButtonThemeData(),
    elevatedButtonTheme: _buildElevatedButtonThemeData(),
    textTheme: _buildTextTheme(),
    outlinedButtonTheme: _buildOutlinedButtonTheme(),
    textButtonTheme: _buildTextButtonThemeData(),
  );

  TextButtonThemeData _buildTextButtonThemeData() => TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: primaryColor,
      disabledBackgroundColor: primaryColorLight,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      textStyle: fontSemiBold.copyWith(fontSize: 16, color: Colors.white),
    ),
  );

  /// 底部导航栏的默认主题
  BottomNavigationBarThemeData _buildBottomNavigationBarThemeData() =>
      BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: primaryColor),
        selectedItemColor: primaryColor,
        selectedLabelStyle: TextStyle(color: primaryColor, fontSize: 12),
        unselectedLabelStyle: TextStyle(
          color: AppColors.color99,
          fontSize: 12,
          fontFamily: "",
        ),
      );

  /// AppBar的默认主题
  AppBarTheme _buildAppBarTheme() => AppBarTheme(
    backgroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(size: 24, color: Colors.black, weight: 300),
    elevation: 0,
    actionsIconTheme: IconThemeData(color: primaryColor),
    titleTextStyle: fontMedium.copyWith(fontSize: 22, color: Colors.black),
  );

  /// 按钮的默认主题样式
  OutlinedButtonThemeData _buildOutlinedButtonTheme() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primaryColor, width: 1),
          foregroundColor: primaryColorLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: Size(double.infinity, 45),
        ),
      );

  ElevatedButtonThemeData _buildElevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            fontSemiBold.copyWith(fontSize: 16, color: Colors.white),
          ),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 11.75),
          ),
        ),
      );

  TextTheme _buildTextTheme() => TextTheme(
    // 通常用于需要强调的文本块，比如列表标题、卡片标题等。
    titleMedium: fontMedium.copyWith(fontSize: 17, color: textColor),
    // 用于较小的文本块，比如列表项标题、卡片副标题等
    titleSmall: fontMedium.copyWith(fontSize: 15, color: textColor),
    // display 一般用于通常用于标题、大型图表和其他需要强调的元素
    // 。它们的字体大小比 `headline` 和 `title` 大，但比 `headline1` 小
    displayMedium: fontSemiBold.copyWith(fontSize: 34, color: primaryColorDark),
    displaySmall: fontMedium.copyWith(fontSize: 15, color: primaryColorDark),
    // 一般用于一些需要强调的小号文本块；比如 登录页的用户协议
    bodySmall: fontRegular.copyWith(fontSize: 11, color: AppColors.color7E),

    /// 一般用与一些提示的按钮文本 比如登录页底部的忘记密码
    bodyLarge: fontRegular.copyWith(
      fontSize: 15,
      color: AppColors.colorAF,
      height: 1.6,
    ),
    labelLarge: fontRegular.copyWith(fontSize: 13, color: Colors.black),
    labelMedium: fontMedium.copyWith(fontSize: 14, color: textColor),
    headlineLarge: fontRegular.copyWith(fontSize: 14, color: Colors.black),
  );

  /// 输入框的默认主题
  InputDecorationTheme _buildInputDecorationTheme() => InputDecorationTheme(
    hintStyle: inputTextHintStyle,
    prefixStyle: inputTextStyle,
    labelStyle: inputTextHintStyle,
    isCollapsed: true,
    contentPadding: EdgeInsets.zero,
    enabledBorder: InputBorder.none,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    counterStyle: inputTextHintStyle.copyWith(fontSize: 14),
  );
}
