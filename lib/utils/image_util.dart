import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rw_base/utils/log_util.dart';
import 'package:image/image.dart' as im;

class ImageUtil {

  /// 获取屏幕上显示的Widget的截图
  static Future<Uint8List?> getWidgetImage(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = context.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: window.devicePixelRatio);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      LogUtil.loggerLevelE(e);
      return null;
    }
  }

  /// 拼接图片
  static Uint8List jointImage(Uint8List image1, Uint8List image2) {
    im.Image? resourceImage1 = im.decodeImage(image1);
    im.Image? resourceImage2 = im.decodeImage(image2);
    im.Image image = im.Image(max(resourceImage1!.width, resourceImage2!.width), resourceImage1.height + resourceImage2.height);
    im.copyInto(image, resourceImage1, blend: false);
    im.copyInto(image, resourceImage2, dstY: resourceImage1.height, blend: false);
    return Uint8List.fromList(im.encodePng(image));
  }
}