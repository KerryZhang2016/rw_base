import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Shimmer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Gradient? gradient;
  final bool enabled;

  const Shimmer({
    Key? key,
    required this.child,
    required this.gradient,
    this.duration = const Duration(milliseconds: 300),
    this.enabled = true,
  }) : super(key: key);

  @override
  _ShimmerState createState() => _ShimmerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>('duration', duration,
        defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enabled', enabled,
            defaultValue: null));
  }
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animation)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    if (widget.enabled) _controller.forward();
  }

  @override
  void didUpdateWidget(Shimmer oldWidget) {
    if (widget.enabled) {
      if (!_controller.isAnimating) {
        _controller.forward(from: 0.0);
      }
    } else {
      _controller.reset();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: _animation,
          child: Container(decoration: BoxDecoration(gradient: widget.gradient)),
        ),
        widget.child
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}