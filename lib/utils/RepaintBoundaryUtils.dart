part of 'utils.dart';

//全局key-截图key
final GlobalKey boundaryKey = GlobalKey();

class RepaintBoundaryUtils {

  final deviceInfoPlugin = DeviceInfoPlugin();
//生成截图
  /// 截屏图片生成图片流ByteData
  Future<String> captureImage() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    var filePath = "";

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // getApplicationDocumentsDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
            "${applicationDir.path}${DateTime.now().toIso8601String()}.jpg")
        .writeAsBytes(pngBytes);
    filePath = saveFile.path;
    // if (Platform.isAndroid) {
    //   // 如果是Android 的话，直接使用image_gallery_saver就可以了
    //   // 图片byte数据转化unit8
    //   Uint8List images = byteData!.buffer.asUint8List();
    //   // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
    //   String result = await ImageGallerySaver.saveImage(images);
    //   // 需要去除掉file://开头。生成要使用的file
    //   File saveFile = new File(result.replaceAll("file://", ""));
    //   filePath = saveFile.path;
    //
    //
    // } else if (Platform.isIOS) {
    //   // 图片byte数据转化unit8
    //
    // }

    return filePath;
  }

  Future<Permission> _getIOSPermission() async {
    final iosInfo = await deviceInfoPlugin.iosInfo;
    /// 如果是ios 14+ 就返回onlyAdd
    if((double.tryParse(iosInfo.systemVersion)??8.0)>14){
      return Permission.photosAddOnly;
    }
    return Permission.photos;
  }
//申请存本地相册权限
  Future<bool> getPermission() async {
    if (Platform.isIOS) {
      final permission = await  _getIOSPermission();
      var status = await permission.status;
      if(!status.isGranted){
        status = await permission.request();
      }
      if(status.isPermanentlyDenied || status.isDenied){
        return false;
      }
      if(status.isLimited || status.isDenied){
        status = await permission.request();
      }
      return true;
    } else {
      final permissions = [Permission.storage, Permission.storage];
      for (var permission in permissions) {
        if (!(await permission.isGranted)) {
          final result = await permission.request();
          if (result == PermissionStatus.denied ||
              result == PermissionStatus.permanentlyDenied) {
            return false;
          }
        }
      }
      return true;
    }
  }

//保存到相册
  Future<void> savePhoto({String? name}) async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;

    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    //获取保存相册权限，如果没有，则申请改权限
    bool isPermission = await getPermission();
    String msg = "save_fail_reject_permission".tr;
    if(!isPermission){
      if (Platform.isIOS){
        var status = await (await _getIOSPermission()).status;
        if(status.isLimited){
          msg = "save_fail_reject_permission.isLimited".tr;
        }
      }
      showMessageDialog(message: msg,confirmText: "go_open".tr).thenTrue((){
        openAppSettings();
      });
      return;
    }
    if (Platform.isIOS) {
      Uint8List images = byteData!.buffer.asUint8List();
      final result = await ImageGallerySaverPlus.saveImage(images,
          quality: 100, name: name);
      if(result["isSuccess"]){
        EasyLoading.showToast('save_success'.tr);
      }else{
        EasyLoading.showToast("save_fail".tr);
      }
    } else {
      Uint8List images = byteData!.buffer.asUint8List();
      final result =
      await ImageGallerySaverPlus.saveImage(images, name: name, quality: 100);
      if (result != null) {
        EasyLoading.showToast("save_success".tr);
      } else {
        EasyLoading.showToast("save_fail".tr);
      }
    }
  }
}
