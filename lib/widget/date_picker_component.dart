import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rw_base/common/resource/color_res.dart';
import 'package:rw_base/utils/screen_util.dart';

/// 自定义的日期选择器
class DatePickerComponent extends StatefulWidget {
  const DatePickerComponent({required this.theme, required this.pickerModel,
    required this.onChanged, this.dayTheme = false, Key? key}) : super(key: key);

  final DatePickerTheme theme;
  final BasePickerModel pickerModel;
  final DateChangedCallback? onChanged;
  final bool dayTheme;

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;
  late DatePickerTheme theme;

  @override
  void initState() {
    super.initState();
    theme = widget.theme;
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.finalTime()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _renderItemView(theme);
  }

  Widget _renderItemView(DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: widget.pickerModel.layoutProportions()[0] > 0
                ? _renderColumnView(
                ValueKey(widget.pickerModel.currentLeftIndex()),
                theme,
                widget.pickerModel.leftStringAtIndex,
                leftScrollCtrl,
                widget.pickerModel.layoutProportions()[0], (index) {
              widget.pickerModel.setLeftIndex(index);
            }, (index) {
              setState(() {
                refreshScrollOffset();
                _notifyDateChanged();
              });
            })
                : null,
          ),
          Container(
            child: widget.pickerModel.layoutProportions()[1] > 0
                ? _renderColumnView(
                ValueKey(widget.pickerModel.currentLeftIndex()),
                theme,
                widget.pickerModel.middleStringAtIndex,
                middleScrollCtrl,
                widget.pickerModel.layoutProportions()[1], (index) {
              widget.pickerModel.setMiddleIndex(index);
            }, (index) {
              setState(() {
                refreshScrollOffset();
                _notifyDateChanged();
              });
            })
                : null,
          ),
          Container(
            child: widget.pickerModel.layoutProportions()[2] > 0
                ? _renderColumnView(
                ValueKey(widget.pickerModel.currentMiddleIndex() * 100 +
                    widget.pickerModel.currentLeftIndex()),
                theme,
                widget.pickerModel.rightStringAtIndex,
                rightScrollCtrl,
                widget.pickerModel.layoutProportions()[2], (index) {
              widget.pickerModel.setRightIndex(index);
            }, (index) {
              setState(() {
                refreshScrollOffset();
                _notifyDateChanged();
              });
            })
                : null,
          ),
        ],
      ),
    );
  }

  Widget _renderColumnView(
      ValueKey key,
      DatePickerTheme theme,
      StringAtIndexCallBack stringAtIndexCB,
      ScrollController scrollController,
      int layoutProportion,
      ValueChanged<int> selectedChangedWhenScrolling,
      ValueChanged<int> selectedChangedWhenScrollEnd,
      ) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        height: theme.containerHeight,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
              notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: theme.itemHeight,
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            selectionOverlay: Container(
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: widget.dayTheme ? StandardColor.N7.dayColor : const Color(0xFF22242B), width: 0.8.dp,),
                    top: BorderSide(color: widget.dayTheme ? StandardColor.N7.dayColor : const Color(0xFF22242B), width: 0.8.dp,),
                  )
              ),
            ),
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              if (content == null) {
                return null;
              }
              return Container(
                height: theme.itemHeight,
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: theme.itemStyle,
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}