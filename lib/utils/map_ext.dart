part of 'utils.dart';
///  Map 的扩展
///  author：cxl
///  date: 2022/10/11
extension MapExtension on Map<String, dynamic> {
  /// 通过[key]从Map 中获取值，如果通过[key]获得的值是 null 那就通过[alternate]中的key去寻找值
  dynamic getV(String key, {List<String>? alternate, dynamic defaultValue}) {
    dynamic value = this[key];
    if (value == null && alternate != null) {
      for (var sKey in alternate) {
        value = this[sKey];
        if (value != null) return value;
      }
    }
    if (this[key] == null) return defaultValue;
    return this[key];
  }

  /// 通过[keyPath] 取值
  /// 如：
  /// {
  /// 'data': {
  ///     'detail': {
  ///       'car_data': '111'
  ///     }
  ///   }
  /// }
  /// getVByKeyPath("data.detail.car_data")
  ///
  dynamic getVByKeyPath(String keyPath) {
    List<String> keys = keyPath.split('.');
    dynamic result = this;
    for (String key in keys) {
      if (result is Map && result.containsKey(key)) {
        result = result[key];
      } else {
        return null; // Or handle error accordingly
      }
    }
    return result;
  }

}
