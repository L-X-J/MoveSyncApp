part of 'utils.dart';
/// 权限管理工具类
class PermissionUtils {
  /// 检测相关权限是否已经打开(根据已有状态值)
  static bool checkPermissionsByStatus(List<PermissionStatus> lists) {
    bool result = true;

    for (PermissionStatus permissionStatus in lists) {
      if (permissionStatus != PermissionStatus.granted) {
        result = false;
        break;
      }
    }

    return result;
  }
  static Future<bool> checkPermissions(List<Permission> permissions) async{
    bool result = true;
    permissions.forEach((element) async {
      var temp = await element.isGranted;
      if(!temp){
        result = false;
      }
    });
    return result;
  }
}
