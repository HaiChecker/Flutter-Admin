import 'package:flutter/material.dart';

class RotationView extends StatefulWidget {
  final Widget child;
  final bool start;
  final Duration? duration;

  const RotationView(
      {super.key, required this.child, this.start = false, this.duration});

  @override
  State<StatefulWidget> createState() => _RotationView();
}

class _RotationView extends State<RotationView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: widget.duration ?? const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.addStatusListener(status);
    if (widget.start) {
      controller.forward();
    }
  }

  void status(AnimationStatus status) {
    if (mounted) {
      if (status == AnimationStatus.completed && widget.start) {
        controller.reset();
        controller.forward();
      }
    }
  }

  @override
  void dispose() {
    controller.removeStatusListener(status);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return RotationTransition(
        turns: animation,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          child: widget.child,
        ),
      );
    });
  }
}
