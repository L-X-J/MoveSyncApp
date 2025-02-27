import 'dart:io';

import 'package:get/get.dart';
import 'package:ms/utils/utils.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'base_reponse.dart';

/// 图片对象
class FileEntity {
  /// 文件在服务里面的 Id
  int? serverFileId;
  /// 文件咋服务器中的名字
  String? serverFileName;
  /// 文件的大小
  int? serverFileSize;
  /// 图片网络地址
  String? netPath;

  /// 图片本地地址
  String? localPath;

  /// 是否处于上传中
  final RxBool uploadIng = RxBool(false);

  /// 上传进度 最大100
  final RxDouble uploadProgress = RxDouble(0);

  final AssetEntity? assetEntity;

  FileEntity._({this.netPath, this.localPath, this.assetEntity,this.serverFileId,this.serverFileName,this.serverFileSize});

  factory FileEntity.net(String? url) => FileEntity._(netPath: url);

  factory FileEntity.local(String? url, {AssetEntity? assetEntity}) =>
      FileEntity._(localPath: url, assetEntity: assetEntity);

  factory FileEntity.server(Map<String,dynamic> json){
    return FileEntity._(
      netPath: json["filepath"],
      serverFileId: json["id"],
      serverFileName: json["filename"],
      serverFileSize: int.tryParse(json.getV("filesize",defaultValue: "-1").toString())??-1,
    );
  }


  String? get url => localPath ?? netPath;

  @override
  String toString() => localPath ?? netPath ?? "";

  static RxList<FileEntity> byStrList(dynamic str) {
    if (str == null || str == '') return RxList.empty(growable: true);
    if (str is String) {
      return str.split(',').map(FileEntity.net).toList().obs;
    }
    return RxList.empty(growable: true);
  }

  /// 是否是图片-通过魔术查询
  Future<bool> isPic() async => await FileUtils.instance.fileIsPic(url!);

  String get name {
    if(serverFileName!=null){
      return serverFileName!;
    }
    final url = this.url;
    if (url == null) return "";
    return url.split('/').last;
  }

  Future<String> get fileSizeStr async {
    if(serverFileSize!=null && serverFileSize!=-1){
      return "${(serverFileSize! / 1024).toStringAsFixed(2)}KB";
    }
    if(localPath!=null){
      File file = File(localPath!);
      if (await file.exists()) {
        return "${(file.lengthSync() / 1024).toStringAsFixed(2)}KB";
      }
    }
    return "";
  }
}

extension ListFileEntityExt on List<FileEntity> {
  /// 是否全部上传完成
  bool isUploadOky() => every(
      (element) => element.uploadIng.value == false && element.netPath != null);
}

class GetCaptchaApiRep {
  final bool result;
  final String? captcha;

  GetCaptchaApiRep({required this.result, this.captcha});

  factory GetCaptchaApiRep.forAPI(BRep rep) {
    String? captcha;
    try {
      if (rep.isSuccess2()) {
        captcha = rep.data["captcha"];
      }
    } catch (_) {}
    return GetCaptchaApiRep(result: rep.isSuccess(), captcha: captcha);
  }
}

/// 网络请求状态
class ApiRequestState<T> {
  late final RxBool _loading;
  late final RxBool _error;
  late final RxString _errorText;
  final Rx<T?> data = Rx(null);

  ApiRequestState(
      {bool loading = true, bool error = false, String errorText = '',T? data}) {
    this._loading = RxBool(loading);
    this._error = RxBool(error);
    this._errorText = RxString(errorText);
    this.data.value = data;
  }

  /// 是否是加载中
  bool get isLoading => _loading.value;

  /// 是否是加载失败
  bool get isError => _error.value;

  /// 加载失败的原因
  String get errorText => _errorText.value;

  /// 是否加载成功
  bool get isSuccess => !isError && !isLoading;

  void toLoading() {
    _loading.value = true;
    _error.value = false;
    _errorText.value = '';
  }

  void toError({String errorText = 'load failed'}) {
    _loading.value = false;
    _error.value = true;
    _errorText.value = errorText;
  }

  void toSuccess({T? data}) {
    _loading.value = false;
    _error.value = false;
    _errorText.value = '';
    this.data.value = data;
  }

  Future<BRep> processByBRep(
      {required Future<BRep> fRep,
      required T Function(Map<String, dynamic> json) apiDataFromJson,
      bool emptyCheck = true}) {
    return fRep.then((rep) {
      if (emptyCheck) {
        if (rep.isSuccess2()) {
          toSuccess(data: apiDataFromJson(rep.data));
        } else {
          toError(errorText: rep.notNullMsg);
        }
      } else {
        if (rep.isSuccess()) {
          toSuccess(data: null);
        } else {
          toError(errorText: rep.notNullMsg);
        }
      }
      return rep;
    }).onError((error, stackTrace) {
      error.printError();
      stackTrace.printError();
      toError(errorText: error.toString());
      return fRep;
    });
  }

  @override
  String toString() {
    return "ApiRequestState{isLoading: $isLoading, isError: $isError, errorText: $errorText,data:$data}";
  }
}

typedef ApiDataFromJson = T Function<T>(Map<String, dynamic> json);

/// 网络请求状态
class ApiRequestListState<T> {
  late final RxBool _loading;
  late final RxBool _error;
  late final RxString _errorText;
  final RxList<T> data = RxList.empty(growable: true);

  ApiRequestListState(
      {bool loading = true, bool error = false, String errorText = ''}) {
    this._loading = RxBool(loading);
    this._error = RxBool(error);
    this._errorText = RxString(errorText);
  }

  /// 是否是加载中
  bool get isLoading => _loading.value;

  /// 是否是加载失败
  bool get isError => _error.value;

  /// 加载失败的原因
  String get errorText => _errorText.value;

  /// 是否加载成功
  bool get isSuccess => !isError && !isLoading;

  void toLoading() {
    _loading.value = true;
    _error.value = false;
    _errorText.value = '';
  }

  void toError({String errorText = 'load failed'}) {
    _loading.value = false;
    _error.value = true;
    _errorText.value = errorText;
  }

  void toSuccess({List<T>? data, bool clearOldData = true}) {
    _loading.value = false;
    _error.value = false;
    _errorText.value = '';
    if (clearOldData) {
      this.data.clear();
    }
    this.data.addAll(data ?? []);
  }

  Future<BRepList> processByBRepList(
      {required Future<BRepList> fRep,
      required T Function(Map<String, dynamic> json) apiDataFromJson,
      bool Function(T data)? removeWhere,
      void Function(List<T> data)? apiDataFromJsonAfter, //数据解析之后执行
      void Function(T data)? forEach, // removeWhere 后执行
      void Function(T data)? beforeForEach, // apiDataFromJsonAfter 后执行
      bool clearOldData = true,
      bool emptyCheck = false}) {
    toLoading();
    return fRep.then((rep) {
      if (emptyCheck) {
        if (rep.isSuccess2()) {
          final data = (rep.dataList?.map(apiDataFromJson).toList() ?? []);
          if (apiDataFromJsonAfter != null) {
            apiDataFromJsonAfter(data);
          }
          if (data.isNotEmpty) {
            if (beforeForEach != null) {
              data.forEach(beforeForEach);
            }
            if (removeWhere != null) {
              data.removeWhere((element) => removeWhere.call(element));
            }
            if (forEach != null) {
              data.forEach(forEach);
            }
          }
          toSuccess(data: data, clearOldData: clearOldData);
        } else {
          toError(errorText: rep.notNullMsg);
        }
      } else {
        if (rep.isSuccess()) {
          final data = (rep.dataList?.map(apiDataFromJson).toList() ?? []);
          if (apiDataFromJsonAfter != null) {
            apiDataFromJsonAfter(data);
          }
          if (data.isNotEmpty) {
            if (beforeForEach != null) {
              data.forEach(beforeForEach);
            }
            if (removeWhere != null) {
              data.removeWhere((element) => removeWhere.call(element));
            }
            if (forEach != null) {
              data.forEach(forEach);
            }
          }
          toSuccess(data: data, clearOldData: clearOldData);
        } else {
          toError(errorText: rep.notNullMsg);
        }
      }
      return rep;
    }).onError((error, stackTrace) {
      error.printError();
      stackTrace.printError();
      toError(errorText: error.toString());
      return fRep;
    });
  }
}

/// 国家码
class CountryCodeBean {
  /// 英文名称
  final String enName;

  /// 中文名
  final String cnName;

  /// 代码
  final String code;

  CountryCodeBean._(this.enName, this.cnName, this.code);

  factory CountryCodeBean.fromJson(Map<String, dynamic> json) {
    return CountryCodeBean._(json['en'], json['cn'], json['code']);
  }

  @override
  int get hashCode => code.hashCode;

  @override
  bool operator ==(Object other) {
    return other is CountryCodeBean && code == other.code;
  }
}
