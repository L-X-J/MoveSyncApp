part of 'utils.dart';

/////////////////////////////////////////////////////////////
//                                                         //
//                                                         //
//                  「文件工具类」                        //
//                                                         //
// @author：cxl                                            //
// @date: 2023/11/30                                       //
/////////////////////////////////////////////////////////////
class FileUtils {
  FileUtils._();

  static final FileUtils _i = FileUtils._();

  static FileUtils get instance => _i;

  Future<String?> getFileType(String filePath) async {
    final File file = File(filePath);
    // 打开文件
    final RandomAccessFile raf = await file.open(mode: FileMode.read);

    // 读取文件的前4个字节
    final Uint8List bytes = await raf.read(4);
    await raf.close();

    // 这里可以添加更多的文件魔数检测逻辑
    // png
    if (bytes.length >= 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'png';
    }
    // %PDF
    if (bytes[0] == 0x37 &&
        bytes[1] == 0x80 &&
        bytes[2] == 0x68 &&
        bytes[3] == 0x70) {
      return 'pdf';
    }
    // pdf
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46) {
      return 'pdf';
    }
    // PDF
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x25 &&
        bytes[2] == 0x50 &&
        bytes[3] == 0x44) {
      return 'pdf';
    }

    // xls
    if (bytes[0] == 0xD0 &&
        bytes[1] == 0xCF &&
        bytes[2] == 0x11 &&
        bytes[3] == 0xE0 &&
        bytes[4] == 0xA1 &&
        bytes[5] == 0xB1 &&
        bytes[6] == 0x1A &&
        bytes[7] == 0xE1) {
      return 'xls';
    }
    // xlsx
    if (bytes[0] == 0x50 &&
        bytes[1] == 0x4B &&
        bytes[2] == 0x03 &&
        bytes[3] == 0x04) {
      return 'xlsx';
    }
    // pptx
    if (bytes[0] == 0x50 && bytes[1] == 0x4B) {
      return 'pptx';
    }
    // jpg
    if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
      return 'jpeg';
    }
    return null;
  }

  /// 兼容某些手机文件名没有后缀
  Future<File?> compatibleFileNoSuffix(String filePath) async {
    final fileName = filePath.substring(filePath.lastIndexOf("/") + 1);

    /// 如果文件名里面没有后缀，后端会文件解析，这里去找一下后缀
    if (!fileName.contains('.')) {
      final fileType = await FileUtils.instance.getFileType(filePath);
      if (fileType == null) {
        return null;
      }
      return File(filePath).copySync("$filePath.$fileType");
    } else {
      return File(filePath);
    }
  }

  /// 文件是否是图片
  Future<bool> fileIsPic(String filePath) async {
    if (filePath.startsWith("http") &&
        (
            filePath.endsWith("png")
                || filePath.endsWith("jpg")
                || filePath.endsWith("jpeg")
        )) {
      return true;
    }
    final File file = File(filePath);
    List<int> headerBytes = (await file.readAsBytes()).sublist(0, 16);
    List<int> jpegMagicNumber = [0xFF, 0xD8];
    List<int> pngMagicNumber = [0x89, 0x50, 0x4E, 0x47];
    List<int> gifMagicNumber = [0x47, 0x49, 0x46];

    if (headerBytes.length >= 2 &&
        headerBytes[0] == pngMagicNumber[0] &&
        headerBytes[1] == pngMagicNumber[1]) {
      return true; // PNG file
    } else if (headerBytes.length >= 2 &&
        headerBytes[0] == jpegMagicNumber[0] &&
        headerBytes[1] == jpegMagicNumber[1]) {
      return true; // JPEG file
    } else if (headerBytes.length >= 3 &&
        headerBytes[0] == gifMagicNumber[0] &&
        headerBytes[1] == gifMagicNumber[1] &&
        headerBytes[2] == gifMagicNumber[2]) {
      return true; // GIF file
    }

    return false; // Not an image file
  }


  /// 文件是否存在
  Future<bool> fileExists(String filePath) async {
    final File file = File(filePath);
    return await file.exists();
  }
}
