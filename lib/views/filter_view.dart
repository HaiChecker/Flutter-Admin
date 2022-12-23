import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  final Widget main;
  final List<Widget> filter;

  const Filter({super.key, required this.main, required this.filter});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return SizedBox(
        width: size.maxWidth,
        height: size.maxHeight,
        child: Column(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: filter,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: main,
            )
          ],
        ),
      );
    });
  }
}
