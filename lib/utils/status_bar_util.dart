import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarUtil {

  /// 更新状态栏样式
  static updateStatusBarStyle(bool isNightMode) {
    if (isNightMode) {// 黑色皮肤
      SystemUiOverlayStyle uiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
    } else {// 白色皮肤
      SystemUiOverlayStyle uiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      );
      SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
    }
  }
}