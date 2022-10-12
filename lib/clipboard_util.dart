
import 'package:flutter/services.dart';

/// 剪切板工具类
class ClipboardUtil {
  
  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String> getData() async {
    var data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text ?? "";
  }
}