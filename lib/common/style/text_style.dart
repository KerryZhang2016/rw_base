
import 'package:flutter/material.dart';
import 'package:rw_base/utils/screen_util.dart';

/// 自定义标准的字体样式获取
TextStyle getNormalTextStyle(Color color, int fontSizePx,
    {TextDecoration decoration = TextDecoration.none,
      double? height, Color? decorationColor}) {
  return TextStyle(
      fontFamily: 'NotoSans',
      decoration: decoration,
      decorationColor: decorationColor,
      color: color,
      fontSize: ScreenUtil.setSp(fontSizePx).toDouble(),
      fontWeight: FontWeight.normal,
      height: height
  );
}

TextStyle getMediumTextStyle(Color color, int fontSizePx) {
  return TextStyle(
      fontFamily: 'NotoSans',
      decoration: TextDecoration.none,
      color: color,
      fontSize: ScreenUtil.setSp(fontSizePx).toDouble(),
      fontWeight: FontWeight.w500
  );
}