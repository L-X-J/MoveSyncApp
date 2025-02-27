/// Api请求 返回数据Response
class BRep {
  String? msg;
  int code;
  dynamic data;

  BRep(this.msg, this.code, {this.data});

  String get notNullMsg => msg ?? "";

  bool isSuccess() => code == 0;

  // 这个函数会验证 data 是否为空
  bool isSuccess2() => code == 0 && data != null;

  factory BRep.fromJson(Map<String, dynamic> json) => BRep(
        json['message'] as String?,
        json['code'] as int,
        data: json['data'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': msg,
        'code': code,
        'data': data,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class BRepList {
  String? msg;
  int code;
  List<Map<String, dynamic>>? dataList;

  BRepList(this.msg, this.code, {this.dataList});

  String get notNullMsg => msg ?? "";

  bool isSuccess() => code == 0;

  bool isSuccess2() => code == 0 && dataList != null;

  factory BRepList.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? data;
    if(json["data"] == null){
      data = null;
    }else if (json['data'] is List<dynamic>) {
      data = (json['data'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();
    } else if (json["data"]["list"] is List<dynamic>) {
      data = (json["data"]["list"] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();
    }else if(json["data"]["list"]["data"] is List<dynamic>){
      data = (json["data"]["list"]["data"] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList();
    }
    return BRepList(json['message'] as String, json['code'] as int,
        dataList: data);
  }
}

/// Api请求 返回数据Response 分页数据
class BRepPage {
  /// 每页数据有多少条
  final int pageSize;

  /// 一共多少条数据
  final int totalCount;

  /// 当前在第几页
  final int currPage;

  /// 一共多少页
  final int totalPage;

  /// 数据
  List<Map<String, dynamic>>? list;

  BRepPage(this.pageSize, this.totalCount, this.currPage, this.totalPage,
      {this.list});

  factory BRepPage.fromJson(dynamic json) => BRepPage(
        json['pageSize'] as int,
        json['totalCount'] as int,
        json['currPage'] as int,
        json['totalPage'] as int,
        list: (json['list'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'pageSize': pageSize,
        'totalCount': totalCount,
        'currPage': currPage,
        'totalPage': totalPage,
        'list': list,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
