import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'log_util.dart';

/// 横向PageView 嵌套滑动工具类
class PageViewScrollUtils {
  final PageController pageController;
  final TabController tabController;
  Drag? _drag;

  PageViewScrollUtils(this.pageController, this.tabController);

  bool handleNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification && (notification.metrics.axisDirection == AxisDirection.right
        || notification.metrics.axisDirection == AxisDirection.left)) {
      if (notification.direction == ScrollDirection.reverse && tabController.index == tabController.length - 1) {
        _drag = pageController.position.drag(DragStartDetails(), () {
          _drag = null;
        });
      } else if (notification.direction == ScrollDirection.forward && tabController.index == 0) {
        _drag = pageController.position.drag(DragStartDetails(), () {
          _drag = null;
        });
      }
    }
    if (notification is OverscrollNotification) {
      if (notification.dragDetails != null && _drag != null) {
        _drag?.update(notification.dragDetails!);
      }
    }
    if (notification is ScrollEndNotification) {
      if (notification.dragDetails != null && _drag != null) {
        _drag?.end(notification.dragDetails!);
      }
    }
    return true;
  }
}

class PageViewScrollUtils2 {
  final PageController pageController;
  Drag? _drag;
  var _dragStartDetails;

  PageViewScrollUtils2(this.pageController);

  bool handleNotification(ScrollNotification notification) {
    if (notification.metrics.axisDirection == AxisDirection.down) return false;

    if (notification is ScrollStartNotification) {
      LogUtil.loggerLevelD("handleNotification ScrollStartNotification");
      _dragStartDetails = notification.dragDetails;
    }
    if (notification is OverscrollNotification) {
      LogUtil.loggerLevelD("handleNotification OverscrollNotification");
      if (notification.dragDetails != null) {
        _drag = pageController.position.drag(_dragStartDetails, () {});
        _drag?.update(notification.dragDetails!);
      }
    }
    if (notification is ScrollEndNotification) {
      LogUtil.loggerLevelD("handleNotification ScrollEndNotification");
      _drag?.cancel();
    }
    return true;

    // if (notification is UserScrollNotification) {
    //   double pixels = notification.metrics.pixels;
    //   double maxScrollExtent = notification.metrics.maxScrollExtent;
    //   LogUtil.loggerLevelD("handleNotification ${notification.direction} ${pixels >= maxScrollExtent} ${pixels == 0}");
    //   if (notification.direction == ScrollDirection.reverse && pixels >= maxScrollExtent) {
    //     _drag = pageController.position.drag(DragStartDetails(), () {
    //       _drag = null;
    //     });
    //   } else if (notification.direction == ScrollDirection.forward && pixels == 0) {
    //     _drag = pageController.position.drag(DragStartDetails(), () {
    //       _drag = null;
    //     });
    //   }
    // }
    // if (notification is OverscrollNotification) {
    //   LogUtil.loggerLevelD("handleNotification OverscrollNotification");
    //   if (notification.dragDetails != null && _drag != null) {
    //     _drag.update(notification.dragDetails);
    //   }
    // }
    // if (notification is ScrollEndNotification) {
    //   LogUtil.loggerLevelD("handleNotification ScrollEndNotification");
    //   if (notification.dragDetails != null && _drag != null) {
    //     _drag.end(notification.dragDetails);
    //   }
    // }
    // return true;
  }
}