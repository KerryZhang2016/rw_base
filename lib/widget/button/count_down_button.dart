// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/utils/screen_util.dart';
import 'package:rw_base/common/style/text_style.dart';
import 'package:rw_base/utils/timer_util.dart';

import '../../generated/l10n.dart';

/// 倒计时按钮
/// 外部触发倒计时状态
class CountButton extends StatefulWidget {
  final bool isEnable;
  final bool isCountDown;
  final int countdown;
  String? text;
  final Function? onTapCallback;
  final Function? onCompleteCallback;

  CountButton({Key? key, this.isEnable = false, this.isCountDown = false, this.countdown = 60,
    this.text, this.onTapCallback, this.onCompleteCallback})
      : super(key: key) {
    text ??= S.current.base_get_check_code;
  }

  @override
  _CountButtonState createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
  TimerUtil? _timerUtil;
  late String _verifyStr;

  @override
  void initState() {
    super.initState();
    _verifyStr = widget.text ?? S.current.base_get_check_code;
  }

  void _startTimer() {
    _timerUtil ??= TimerUtil();
    _timerUtil?.setTotalTime(widget.countdown * 1000);
    _timerUtil?.setOnTimerTickCallback((time) {
      if (time == 0) {
        _timerUtil?.cancel();
        setState(() {
          widget.onCompleteCallback?.call();
          _verifyStr = widget.text ?? S.current.base_get_check_code;
        });
      } else {
        setState(() {
          _verifyStr = "${S.current.base_already_send_msg}(${time ~/ 1000}s)";
        });
      }
    });
    _timerUtil?.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCountDown && _timerUtil?.isActive() != true) {
      _startTimer();
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!widget.isCountDown && widget.isEnable) {
          widget.onTapCallback?.call();
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.dp),
        child: Text(_verifyStr,
          style: getNormalTextStyle(widget.isCountDown || !widget.isEnable
              ? StandardColor.O1.color.withOpacity(0.4) : StandardColor.O1.color, 16),
        )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timerUtil?.cancel();
  }
}
