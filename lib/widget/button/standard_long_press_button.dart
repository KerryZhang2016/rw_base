// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/common/style/text_style.dart';
import 'package:rw_base/utils/timer_util.dart';
import 'package:rw_base/utils/screen_util.dart';

/// 支持长按自步的按钮
// ignore: must_be_immutable
class StandardLongPressButton extends StatefulWidget {
  VoidCallback? onPressed;
  bool isButton;
  String? text;
  Widget? widget;

  StandardLongPressButton({Key? key, this.onPressed, this.isButton = true,
    this.text, this.widget}) : super(key: key);

  @override
  _StandardLongPressButtonState createState() => _StandardLongPressButtonState();
}

class _StandardLongPressButtonState extends State<StandardLongPressButton> {
  static const int TIMER_INTERVAL = 100;
  static const int COUNT_DOWN_INTERVAL = 150;

  TimerUtil? _stepTimerUtil;// 计步器
  TimerUtil? _timerUtil;// 延迟器
  bool _highlight = false;

  void _startStep() {
    _cancelStep();
    if (!_highlight) return;
    if (_stepTimerUtil == null) {
      _stepTimerUtil = TimerUtil(interval: TIMER_INTERVAL);
      _stepTimerUtil?.setOnTimerTickCallback((int time) {
        if (_highlight) {
          widget.onPressed?.call();
        }
      });
      _stepTimerUtil?.startTimer();
    }
  }

  void _cancelStep() {
    _stepTimerUtil?.cancel();
    _stepTimerUtil = null;
  }

  void _startTimer() {
    if (_timerUtil == null) {
      _timerUtil = TimerUtil(totalTime: COUNT_DOWN_INTERVAL);
      _timerUtil?.setOnTimerTickCallback((time) {
        if (time == 0) {
          _startStep();
        }
      });
      _timerUtil?.startCountDown();
    }
  }

  void _stopTimer() {
    _timerUtil?.cancel();
    _timerUtil = null;
  }

  @override
  void dispose() {
    super.dispose();
    _cancelStep();
    _stopTimer();
  }

  @override
  void initState() {
    super.initState();
    _highlight = false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isButton ? SizedBox(
      width: double.infinity,
      child: TextButton(
          onPressed: () {
            widget.onPressed?.call();
          },
          onHover: (b) {
            _highlight = b;
            if (b) {
              _startTimer();
            } else {
              _stopTimer();
              _cancelStep();
            }
          },
          style: ButtonStyle(
            //定义文本的样式 这里设置的颜色是不起作用的
            textStyle: MaterialStateProperty.all(
                getNormalTextStyle(StandardColor.N2.color, 20)
            ),
            //文案颜色
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled) || states.contains(MaterialState.pressed)) {
                return StandardColor.Btn_Disable_Text.color;
              }
              return StandardColor.N2.color;
            },
            ),
            //背景颜色
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return StandardColor.N1.color;
              } else if (states.contains(MaterialState.disabled)) {
                return StandardColor.Keyboard_Button_bg.color;
              }
              return StandardColor.Keyboard_Button_bg.color;
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
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.dp))),
          ),
          child: widget.widget ?? Text(widget.text ?? "", maxLines: 1, overflow: TextOverflow.ellipsis)
      )
    ) : Listener(
      onPointerDown: (PointerDownEvent event) {
        _highlight = true;
        _startTimer();
      },
      onPointerUp: (PointerUpEvent event) {
        _highlight = false;
        _stopTimer();
        _cancelStep();
      },
      child: GestureDetector(
        onTap: () {
          widget.onPressed?.call();
        },
        behavior: HitTestBehavior.translucent,
        child: widget.widget,
      ),
    );
  }
}

