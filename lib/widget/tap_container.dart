import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 添加按下效果的容器
class TapContainer extends StatefulWidget {
  const TapContainer(
      {Key? key,
        this.onTap,
        this.onLongPress,
        required this.normalChild,
        required this.pressedChild})
      : super(key: key);

  final Widget normalChild;
  final Widget pressedChild;
  final Function? onTap;
  final Function? onLongPress;

  @override
  State<StatefulWidget> createState() => _TapContainerState();
}

class _TapContainerState extends State<TapContainer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(microseconds: 250));
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.onTap == null ? null : () {
          widget.onTap?.call();
        },
        onLongPress: widget.onLongPress == null ? null : () {
          widget.onLongPress?.call();
        },
        onTapDown: (d) => _animationController.forward(),
        onTapUp: (d) => _prepareToIdle(),
        onTapCancel: () => _prepareToIdle(),
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return Container(
                child: _animationController.value == 0
                    ? widget.normalChild
                    : widget.pressedChild,
              );
            }));
  }

  void _prepareToIdle() {
    AnimationStatusListener? listener;
    listener = (AnimationStatus statue) {
      if (statue == AnimationStatus.completed) {
        _animationController.removeStatusListener(listener!);
        _toStart();
      }
    };
    _animationController.addStatusListener(listener);
    if (!_animationController.isAnimating) {
      _animationController.removeStatusListener(listener);
      _toStart();
    }
  }

  void _toStart() {
    _animationController.stop();
    _animationController.reverse();
  }
}
