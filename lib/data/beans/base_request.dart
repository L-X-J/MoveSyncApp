/// 分页参数
class PageParameter {
  /// 分页页码，数字类型
  final int page;

  /// 每页数量
  final int limit;

  PageParameter({this.page = 1, this.limit = 10});

  factory PageParameter.fromJson(Map<String, dynamic> json) => PageParameter(
        page: json['page'] as int? ?? 1,
        limit: json['limit'] as int? ?? 10,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'limit': limit,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
