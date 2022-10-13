import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/common/style/text_style.dart';
import 'package:rw_base/utils/screen_util.dart';

// ignore: must_be_immutable
class StandardButton extends StatelessWidget {
  StandardButton({Key? key, this.onPressed, this.text, this.fontSizePx,
    this.widget, this.backgroundColor, this.dayTheme = false}) : super(key: key);

  VoidCallback? onPressed;
  String? text;
  int? fontSizePx;
  Widget? widget;
  Color? backgroundColor;
  bool dayTheme;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          //定义文本的样式 这里设置的颜色是不起作用的
          textStyle: MaterialStateProperty.all(
              getMediumTextStyle(dayTheme? StandardColor.Btn_Text.dayColor : StandardColor.Btn_Text.color, fontSizePx ?? 16)
          ),
          //文案颜色
          foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled) || states.contains(MaterialState.pressed)) {
                return dayTheme? StandardColor.Btn_Disable_Text.dayColor : StandardColor.Btn_Disable_Text.color;
              }
              return dayTheme? StandardColor.Btn_Text.dayColor : StandardColor.Btn_Text.color;
            },
          ),
          //背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (backgroundColor != null) return backgroundColor;
            if (states.contains(MaterialState.pressed)) {
              return dayTheme? StandardColor.Btn_Highlight_Bg.dayColor : StandardColor.Btn_Highlight_Bg.color;
            } else if (states.contains(MaterialState.disabled)) {
              return dayTheme? StandardColor.Btn_Disable_Bg.dayColor : StandardColor.Btn_Disable_Bg.color;
            }
            return dayTheme? StandardColor.O1.dayColor : StandardColor.O1.color;
          }),
          //设置水波纹颜色
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          //设置阴影  不适用于这里的TextButton
          elevation: MaterialStateProperty.all(0),
          //设置按钮内边距
          // padding: MaterialStateProperty.all(EdgeInsets.all(0)),
          //设置按钮的大小
          // minimumSize: MaterialStateProperty.all(Size(200, 100)),
          //设置边框
          // side: MaterialStateProperty.all(BorderSide(color: Colors.grey, width: 1)),
          //外边框装饰 会覆盖 side 配置的样式
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.dp))),
        ),
        child: widget ?? Text(text ?? "", maxLines: 1, overflow: TextOverflow.ellipsis)
    );
  }
}