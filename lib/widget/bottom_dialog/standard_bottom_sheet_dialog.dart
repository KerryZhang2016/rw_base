
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/common/style/text_style.dart';
import 'package:rw_base/utils/screen_util.dart';

import '../../generated/l10n.dart';

/// 底部弹出选择窗口 (返回-1/null为取消)
Future<int?> showStandardBottomSheetDialog(BuildContext context, List<String> selections, {bool dayTheme = false}) async {
  return await showModalBottomSheet<int?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StandardBottomSheetDialog(selections, dayTheme);
    },
  );
}

// ignore: must_be_immutable
class StandardBottomSheetDialog extends StatefulWidget {
  final List<String> selections;
  final bool dayTheme;

  const StandardBottomSheetDialog(this.selections, this.dayTheme, {Key? key}) : super(key: key);

  @override
  _StandardBottomSheetDialogState createState() => _StandardBottomSheetDialogState();
}

class _StandardBottomSheetDialogState extends State<StandardBottomSheetDialog> {

  @override
  Widget build(BuildContext context) {
    final bottomOffset = MediaQuery.of(context).padding.bottom;
    double listHeight = (min(widget.selections.length, 10.5)) * 52.dp;
    return Container(
      decoration: BoxDecoration(
          color: widget.dayTheme ? StandardColor.N5.dayColor : StandardColor.N5.color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.dp),
              topRight: Radius.circular(12.dp)
          )
      ),
      padding: EdgeInsets.only(bottom: bottomOffset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: listHeight,
              child: SingleChildScrollView(
                  child: Column(
                    children: _buildSelections(),
                  )
              )
          ),
          _buildTab(-1, S.current.base_btn_cancel, widget.dayTheme ? StandardColor.N3.dayColor : StandardColor.N3.color)
        ],
      ),
    );
  }

  List<Widget> _buildSelections() {
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < widget.selections.length; i++) {
      widgets.add(_buildTab(i, widget.selections[i], widget.dayTheme ? StandardColor.N2.dayColor : StandardColor.N2.color));
    }
    return widgets;
  }

  Widget _buildTab(int index, String text, Color textColor) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).pop(index);
      },
      child: Container(
        height: 49.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(
              color: index == -1 ? Colors.transparent : (widget.dayTheme ? StandardColor.N6.dayColor : StandardColor.N6.color),
              width: 0.5.dp,
            ))
        ),
        child: Text(text,
          style: getNormalTextStyle(textColor, 16),),
      ),
    );
  }
}