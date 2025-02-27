import 'dart:io';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ms/data/beans/common_beans.dart';

///  图片显示
///  author：cxl
///  date: 2022/10/20
class ImageView {
  /// 默认图片地址
  static const _defaultImagePath = "assets/images/default.png";

  /// 默认加载失败的图片
  static const _defaultErrorImagePath = "assets/images/default_error.png";

  /// 默认头像地址
  static const defaultAvatarPath = "assets/images/default_avatar.png";

  /// 默认企业LOGO
  static const _defaultCompanyLogoPath =
      "assets/images/default_company_logo.svg";

  ImageView._();

  /// 加载图片
  /// 可加载 项目资源文件(包含svg)
  /// 可加载 本地资源文件
  /// 可加载网络资源文件
  static Widget load(
    String? url, {
    double radius = 0,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    ExtendedImageMode mode = ExtendedImageMode.none,
    LoadStateChanged? loadStateChanged,
    Color? color,
    String? defaultImg,
  }) {
    if (url == null || url.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          _defaultImagePath,
          width: width,
          height: height,
          fit: BoxFit.contain,
          color: color,
          colorBlendMode: BlendMode.colorBurn,
        ),
      );
    }
    // 如果是 项目中的资源文件 且文件后缀是.svg
    if (url.startsWith("assets/images/") && url.endsWith(".svg")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SvgPicture.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: BlendMode.colorBurn,
        ),
      );
    }
    // 如果是 项目中的资源文件
    if (url.startsWith("assets/images/")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          url,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: BlendMode.colorBurn,
        ),
      );
    }

    // 如果是不是 网络图片 就把它当成本地图片
    if (!url.startsWith("http://") && !url.startsWith("https://")) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: width,
          height: height,
          child: ExtendedImage.file(
            File(url),
            width: double.infinity,
            height: double.infinity,
            fit: fit,
            mode: mode,
            color: color,
            colorBlendMode: BlendMode.colorBurn,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            loadStateChanged:
                (state) =>
                    loadStateChanged?.call(state) ??
                    _loadStateChanged(
                      state,
                      radius: radius,
                      width: width,
                      height: height,
                      fit: fit,
                      defaultImg: defaultImg,
                    ),
          ),
        ),
      );
    }
    // 否者一律按照网络图片进行加载
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: width,
        height: height,
        child: ExtendedImage.network(
          url,
          width: double.infinity,
          height: double.infinity,
          fit: fit,
          mode: mode,
          color: color,
          colorBlendMode: BlendMode.colorBurn,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          loadStateChanged:
              (state) =>
                  loadStateChanged?.call(state) ??
                  _loadStateChanged(
                    state,
                    radius: radius,
                    width: width,
                    height: height,
                    fit: fit,
                    defaultImg: defaultImg,
                  ),
        ),
      ),
    );
  }

  static Widget avatar2(
    FileEntity? avatar, {
    double radius = 8,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? color,
    ExtendedImageMode mode = ExtendedImageMode.none,
    LoadStateChanged? loadStateChanged,
  }) {
    return load(
      avatar == null || avatar.toString().isEmpty
          ? defaultAvatarPath
          : avatar.toString(),
      radius: radius == 0 ? 90 : radius,
      width: width ?? 50,
      height: height ?? 50,
      fit: fit,
      mode: mode,
      color: color,
      defaultImg: defaultAvatarPath,
      loadStateChanged: loadStateChanged,
    );
  }

  /// 企业logo
  static Widget companyLogo(
    String? url, {
    double radius = 8,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Color? color,
    ExtendedImageMode mode = ExtendedImageMode.none,
    LoadStateChanged? loadStateChanged,
  }) {
    return load(
      url == null || url.isEmpty ? _defaultCompanyLogoPath : url,
      radius: radius == 0 ? 90 : radius,
      width: width ?? 40,
      height: height ?? 40,
      fit: fit,
      mode: mode,
      color: color,
      defaultImg: _defaultCompanyLogoPath,
      loadStateChanged: loadStateChanged,
    );
  }

  static Widget avatar(
    String? url, {
    double radius = 8,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ExtendedImageMode mode = ExtendedImageMode.none,
    LoadStateChanged? loadStateChanged,
    Color? color,
  }) {
    return load(
      url == null || url.isEmpty ? defaultAvatarPath : url,
      radius: radius == 0 ? 90 : radius,
      width: width ?? 50,
      height: height ?? 50,
      fit: fit,
      mode: mode,
      color: color,
      defaultImg: defaultAvatarPath,
      loadStateChanged: loadStateChanged,
    );
  }

  static Widget? _loadStateChanged(
    ExtendedImageState state, {
    double radius = 0,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    String? defaultImg,
  }) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return _loadingImage(
          radius: radius,
          width: width,
          height: height,
          fit: fit,
          defaultImg: defaultImg,
        );
      case LoadState.completed:
        return state.completedWidget;
      case LoadState.failed:
        return _errorImage(
          radius: radius,
          width: width,
          height: height,
          fit: fit,
          defaultImg: defaultImg,
        );
    }
  }

  /// 图片加载错误显示的组件
  static Widget _errorImage({
    double radius = 0,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    String? defaultImg,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          defaultImg ?? _defaultErrorImagePath,
          width: width,
          height: height,
          fit: defaultImg != null ? fit : BoxFit.contain,
        ),
      ),
    );
  }

  /// 图片加载中显示的组件
  static Widget _loadingImage({
    double radius = 0,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    String? defaultImg,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          defaultImg ?? _defaultImagePath,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// 显示大图预览
  static showBigPreview({required String? url, String? defaultImg}) {
    SmartDialog.show(
      maskWidget: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: InkWell(
          onTap: () {
            SmartDialog.dismiss();
          },
        ),
      ),
      builder:
          (_) => InkWell(
            onTap: () {
              SmartDialog.dismiss();
            },
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: load(
                url,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                height: double.infinity,
                width: double.infinity,
                defaultImg: defaultImg,
              ),
            ),
          ),
    );
  }
}
