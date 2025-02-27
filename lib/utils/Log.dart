part of 'utils.dart';

///  日志相关
///  author：cxl
///  date: 2022/9/15
class Log {
  static final _logger = Logger(
    output: _AppFileOutput(),
    printer: PrettyPrinter(methodCount: 0),
    filter: ProductionFilter(),
  );

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(Level.verbose, message, error: error, stackTrace: stackTrace);
  }

  static void d(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
    bool outWebLog = true,
  ]) {
    _logger.log(Level.debug, message, error: error, stackTrace: stackTrace);
  }


  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(Level.info, message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(Level.warning, message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(Level.error, message, error: error, stackTrace: stackTrace);
  }

  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.log(
      Level.fatal,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void getxLog(String text, {bool? isError}) {
    if (isError == true) {
      _logger.log(Level.error, text);
    } /*else{ //这日志太烦了 注释掉
      _logger.log(Level.verbose, text);
    }*/
  }

  /// 获取设备日志输出文件
  static Future<File> getDeviceLogFile() async {
    final cacheDir = await getApplicationCacheDirectory();
    final logOutDir = Directory("${cacheDir.absolute.path}/log_out");
    if (!logOutDir.existsSync()) {
      await logOutDir.create();
    }
    return File("${logOutDir.absolute.path}/log_out.txt");
  }
}

class _AppFileOutput extends LogOutput {
  IOSink? _sink;

  @override
  Future<void> init() async {
    final file = await Log.getDeviceLogFile();

    /// 如果这个文件超过 10mb，且日期不是 7 天内的，就清空一次这个文件
    if (file.existsSync()) {
      final stat = file.statSync();
      if (stat.size > 10 * 1024 * 1024) {
        final nowDate = DateTime.now();
        final lastModified = stat.modified;
        if (nowDate.difference(lastModified).inDays > 7) {
          await file.writeAsString('');
        }
      }
    }
    _sink = file.openWrite(mode: FileMode.writeOnlyAppend, encoding: utf8);
    return super.init();
  }

  @override
  void output(OutputEvent event) {
    event.lines.forEach(print);
    final nowDate = DateTime.now();
    _sink?.write("${nowDate.toString()} ");
    _sink?.writeAll(event.lines, '\n');
    _sink?.writeln();
  }

  @override
  Future<void> destroy() async {
    await _sink?.flush();
    await _sink?.close();
  }
}
