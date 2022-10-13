import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/common/style/text_style.dart';
import 'package:rw_base/utils/screen_util.dart';

typedef StandardPopupWindowCallback = void Function(int index);

class StandardPopupWindow {
  static final StandardPopupWindow _singleton = StandardPopupWindow._internal();

  factory StandardPopupWindow() {
    return _singleton;
  }

  StandardPopupWindow._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(BuildContext context, double globalDy, int current, List<String> selections,
      StandardPopupWindowCallback callback, {double? left}) async {
    overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(builder: (BuildContext context) =>
        _buildPopupWindowLayout(globalDy, left, current, selections, callback));
    overlayState?.insert(_overlayEntry!);
    _isVisible = true;
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }

  static LayoutBuilder _buildPopupWindowLayout(double globalDy, double? left, int current, List<String> selections,
      StandardPopupWindowCallback callback) {
    List<Widget> list = <Widget>[];
    for (int i = 0; i < selections.length; i++) {
      list.add(Expanded(child: _buildItem(i, selections[i], current, callback)),);
    }

    return LayoutBuilder(builder: (context, constraints) {
      double height = selections.length * 40.dp;
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {dismiss();},
            child: Container(
              alignment: left != null ? Alignment.bottomLeft : Alignment.bottomRight,
              padding: EdgeInsets.only(bottom: constraints.biggest.height - globalDy - height - 35.dp, right: left != null ? 0 : 12.dp, left: left ?? 0),
              child: Container(
                width: 74.dp,
                height: selections.length * 40.dp,
                decoration: BoxDecoration(
                    color: StandardColor.Watchlist_Popup_Window_Bg.color,
                    borderRadius: BorderRadius.circular(4.dp)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: list,
                ),
              ),
            )
        ),
      );
    });
  }

  static Widget _buildItem(int index, String text, int current, StandardPopupWindowCallback callback) {
    return GestureDetector(
        onTap: () {
          if (index != current) {
            callback(index);
          }
          dismiss();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          alignment: Alignment.center,
          height: 40.dp,
          child: Text(text,
            style: getNormalTextStyle(index == current ? StandardColor.O1.color : StandardColor.N2.color, 16),),
        )
    );
  }
}