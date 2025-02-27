part of 'utils.dart';

///  Future 范型 是bool的扩展
///  author：cxl
///  date: 2023/10/9
extension FutureTExtension<T> on Future<T> {
  /// 只有内部值是True的时候才会 执行[action]
  Future<T> thenTrue(Function() action, {Function? onError}) {
    return then((value) {
      if (value == true) {
        action.call();
      }
      return value;
    }, onError: onError);
  }

  /// 只有内部值是False的时候才会 执行[action]
  Future<T> thenFalse(Function() action, {Function? onError}) {
    return then((value) {
      if (value == false) {
        action.call();
      }
      return value;
    }, onError: onError);
  }
}

extension FutureNullSafeTExtension<T> on Future<T?> {
  /// 只有内部值不是Null的时候才会 执行[action]
  Future<T?> thenNotNull(Function(T) action, {Function? onError}) {
    return then((value) {
      if (value != null) {
        action.call(value);
      }
      return value;
    }, onError: onError);
  }
}

extension FutureBRepListExtension on Future<BRepList> {
  Future<BRepList> thenBRepListSuccess2(
    Function(List<Map<String, dynamic>>) action, {
    Function? onError,
    Function(BRepList)? onDataNull,
  }) {
    return then((value) {
      if ((value).isSuccess2()) {
        action.call(value.dataList!);
      } else {
        onDataNull?.call(value);
      }
      return value;
    });
  }

  Future<IndicatorResult> thenEasyRefreshResult({
    required bool refresh,
    Function()? onSuccess,
    int max = ApiConstants.defaultPageSize,
  }) {
    return then((value) {
      if (value.isSuccess2()) {
        onSuccess?.call();
        if (!refresh && (value.dataList?.length ?? 0) < max) {
          return IndicatorResult.noMore;
        } else {
          return IndicatorResult.success;
        }
      }
      return IndicatorResult.fail;
    });
  }
}

extension FutureBRepExtension on Future<BRep> {
  Future<BRep> thenBRepSuccess(Function(BRep) action, {Function? onError}) {
    return then((value) {
      if ((value).isSuccess()) {
        action.call(value);
      }
      return value;
    }, onError: onError);
  }

  Future<BRep> thenBRepSuccess2(
    Function(dynamic data) action, {
    Function? onError,
  }) {
    return then((value) {
      if ((value).isSuccess2()) {
        action.call(value.data);
      }
      return value;
    }, onError: onError);
  }

  Future<IndicatorResult> thenEasyRefreshResult({Function()? onSuccess}) {
    return then((value) {
      if (value.isSuccess2()) {
        onSuccess?.call();
        return IndicatorResult.success;
      }
      return IndicatorResult.fail;
    });
  }
}

/// 处理图片选择起权限被永久拒绝的情况
FutureOr<Null> permissionDeniedToProcessImageSelector(
  Object error,
  StackTrace stackTrace,
) async {
  if (await PhotoManager.requestPermissionExtend() == PermissionState.denied) {
    // 无权限
    showConformDialog(
      "此功能，需要访问【相机相册】权限，由于命明确拒绝了，访问相机相册权限，所以您需要手动开启",
      confirmText: "手动开启",
    ).thenTrue(() {
      openAppSettings();
    });
  }
  return null;
}

extension FilePickerExtension on Future<FilePickerResult?> {
  /// 选择单独的文件，这个函数会兼容，某些手机没有文件后缀的情况(前提：[forceFileType]为`true`)
  /// [fileSizeLimit] 文件大小限制
  /// [forceFileType] 是否强制有文件类型
  Future<File?> thenSingleFile({
    int fileSizeLimit = 36700160,
    bool forceFileType = true,
  }) {
    return then((result) {
      if (result == null) {
        return null;
      }
      if (result.files.isEmpty) {
        return null;
      }
      final PlatformFile file = result.files.single;

      /// 文件大小限制  35mb
      if (file.size > fileSizeLimit) {
        EasyLoading.showInfo(
          'merchant_center.auth.inventory.file_size_limit.tips'.tr,
        );
        return null;
      }
      if (forceFileType) {
        return FileUtils.instance.compatibleFileNoSuffix(file.path!).then((
          value,
        ) {
          if (value == null) {
            /// 没有找到这个文件的真实类型，不让他上传
            EasyLoading.showInfo(
              'merchant_center.auth.inventory.file_type_limit.tips'.tr,
            );
          }
          return value;
        });
      }
      return File(file.path!);
    });
  }
}
