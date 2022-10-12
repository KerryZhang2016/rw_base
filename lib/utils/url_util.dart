import 'package:url_launcher/url_launcher.dart';

import 'log_util.dart';

/// Url跳转工具
class UrlUtil {

  /// 启动Url
  /// [forceWebView] 强制使用浏览器打开,否则寻找系统组件
  static void launchUrl(String? url, {bool forceWebView = false}) async {
    if (url == null || url.isEmpty) return;
    try {
      launch(url, forceWebView: forceWebView);
    } catch (e) {
      LogUtil.loggerLevelE(e);
    }
  }

  /// 拨打电话客服
  static void callPhoneService() async {
    String url = "tel:01052903700";
    if (await canLaunch(url)) {
      launch(url);
    } else {
      LogUtil.loggerLevelE('Could not launch $url');
    }
  }
}