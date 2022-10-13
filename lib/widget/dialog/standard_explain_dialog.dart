
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/utils/screen_util.dart';
import 'package:rw_base/common/style/text_style.dart';

import '../../generated/l10n.dart';
import '../button/standard_button.dart';
import '../button/standard_cancel_button.dart';

Future<bool?> showStandardExplainDialog(BuildContext context, String title, String content,
    {String? btnText, bool outsideDismiss = false, bool highlightMode = false, VoidCallback? onPressed}) async {
  btnText = btnText ?? S.current.base_btn_cancel;
  return await showGeneralDialog(
    context: context,
    barrierDismissible: outsideDismiss,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Dialog(
          backgroundColor: StandardColor.N5.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.dp),
          ),
          child: BaseExplainDialog(title, content, btnText!, outsideDismiss, highlightMode, onPressed)
      );
    },
    transitionDuration: const Duration(milliseconds: 210),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      var scaleValue = 1.1 - 0.1 * animation.value;
      return Transform.scale(
        scale: scaleValue,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}

// ignore: must_be_immutable
class BaseExplainDialog extends StatelessWidget {
  String title;
  String content;
  String btnText;
  bool outsideDismiss;
  bool highlightMode;
  VoidCallback? onPressed;

  BaseExplainDialog(this.title, this.content, this.btnText, this.outsideDismiss, this.highlightMode, this.onPressed,
      {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return outsideDismiss;
      },
      child: SizedBox(
        width: 290.dp,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            20.dividerV,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.dp),
              child: Text(title, style: getMediumTextStyle(StandardColor.N2.color, 17),
                  maxLines: 2, textAlign: TextAlign.center),
            ),
            Container(
                margin: EdgeInsets.only(top: 22.dp, left: 20.dp, right: 20.dp),
                constraints: BoxConstraints(maxHeight: 220.dp),
                child: CupertinoScrollbar(
                    child: SingleChildScrollView(
                        child: Text(content, style: getNormalTextStyle(highlightMode ? StandardColor.N2.color : StandardColor.N3.color, highlightMode ? 17 : 14),
                            textAlign: TextAlign.left)
                    )
                )
            ),
            Container(
              height: 44.dp,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: highlightMode ? 40.dp : 28.dp, left: 20.dp, right: 20.dp),
              child: highlightMode ? SizedBox(
                width: double.infinity,
                height: 44.dp,
                child: StandardButton(
                  onPressed: onPressed ?? () {
                    Navigator.of(context).pop(true);
                  },
                  text: btnText,
                ),
              ) : SizedBox(
                  width: 118.dp,
                  height: 44.dp,
                  child: StandardCancelButton(
                    onPressed: onPressed ?? () {
                      Navigator.of(context).pop(false);
                    },
                    text: btnText,
                  )
              )
            ),
            20.dividerV
          ],
        ),
      ),
    );
  }
}