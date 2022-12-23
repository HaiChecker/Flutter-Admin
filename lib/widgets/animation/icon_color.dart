import 'package:flutter/material.dart';

class IconColor extends ImplicitlyAnimatedWidget {
  final Icon icon;
  final Color color;

  const IconColor(
    this.icon, {
    required this.color,
    super.key,
    super.curve = Curves.linear,
    required super.duration,
  });

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconColor();
}

class _IconColor extends AnimatedWidgetBaseState<IconColor> {
  ColorTween? _color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon.icon,
      size: widget.icon.size,
      color: _color?.evaluate(animation),
      semanticLabel: widget.icon.semanticLabel,
      textDirection: widget.icon.textDirection,
      shadows: widget.icon.shadows,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color,
        (dynamic value) => ColorTween(begin: value as Color?)) as ColorTween?;
  }
}
