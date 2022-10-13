
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/utils/screen_util.dart';
import 'package:rw_base/common/style/text_style.dart';

import '../../generated/l10n.dart';
import '../button/standard_button.dart';
import '../button/standard_cancel_button.dart';

/// [title] 可为空
/// [content] 可为空
Future<bool?> showStandardDialog(BuildContext context, String title, String content,
    {String? leftButton, String? rightButton, bool outsideDismiss = false, bool dayTheme = false}) async {
  leftButton = leftButton ?? S.current.base_btn_cancel;
  rightButton = rightButton ?? S.current.base_btn_confirm;
  return await showGeneralDialog(
    context: context,
    barrierDismissible: outsideDismiss,
    barrierLabel: "",
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Dialog(
          backgroundColor: StandardColor.N5.getColor(dayTheme),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.dp),
          ),
          child: BaseDialog(title, content, leftButton!, rightButton!, outsideDismiss, dayTheme)
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
class BaseDialog extends StatelessWidget {
  String title;
  String content;
  String leftButton;
  String rightButton;
  bool outsideDismiss;
  bool dayTheme;

  BaseDialog(this.title, this.content, this.leftButton, this.rightButton,
      this.outsideDismiss, this.dayTheme, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return outsideDismiss;
      },
      child: Container(
        width: 290.dp,
        padding: EdgeInsets.symmetric(vertical: 20.dp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (title.isNotEmpty == true)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.dp),
                child: Text(title, style: getMediumTextStyle(StandardColor.N2.getColor(dayTheme), 17),
                    maxLines: 2, textAlign: TextAlign.center),
              ),
            if (content.isNotEmpty == true)
              Container(
                  margin: EdgeInsets.only(top: 22.dp, left: 20.dp, right: 20.dp),
                  constraints: BoxConstraints(
                      maxHeight: 110.dp
                  ),
                  child: CupertinoScrollbar(
                      child: SingleChildScrollView(
                          child: Text(content, style: getNormalTextStyle(StandardColor.N3.getColor(dayTheme), 14),
                              textAlign: TextAlign.left)
                      )
                  )
              ),
            28.dividerV,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.dp),
              height: 44.dp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                        height: 44.dp,
                        child: StandardCancelButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          text: leftButton,
                          dayTheme: dayTheme,
                        )
                      )
                  ),
                  14.dividerH,
                  Expanded(
                      child: SizedBox(
                        height: 44.dp,
                        child: StandardButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          text: rightButton,
                          dayTheme: dayTheme,
                        ),
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}