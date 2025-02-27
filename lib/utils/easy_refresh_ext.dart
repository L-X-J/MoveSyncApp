part of 'utils.dart';

extension EasyRefreshControllerExt on EasyRefreshController {
  void finish({required bool success, bool noMore = false}) {
    if (headerState?.mode == IndicatorMode.processing ||
        headerState?.mode == IndicatorMode.processed) {
      // 如果是刷新中状态
      finishRefresh(success && noMore
          ? IndicatorResult.noMore
          : (success ? IndicatorResult.success : IndicatorResult.fail));
      resetFooter();
    } else if ((footerState?.mode == IndicatorMode.processing ||
        footerState?.mode == IndicatorMode.processed)) {
      finishLoad(success && noMore
          ? IndicatorResult.noMore
          : (success ? IndicatorResult.success : IndicatorResult.fail));
    }
  }
}
