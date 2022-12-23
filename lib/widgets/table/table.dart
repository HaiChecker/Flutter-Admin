import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_admin/config/logger.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/table/controller.dart';
import 'package:flutter_admin/widgets/table/style.dart';
import 'package:flutter_admin/widgets/table/table_item.dart';
import 'package:tuple/tuple.dart';

class AdminTable<T> extends StatefulWidget {
  final AdminTableController<T> controller;
  final double height;
  final bool fixedHeader;
  final AdminTableStyle? tableStyle;
  final AdminTableItemStyle? tableItemStyle;
  final BoxDecoration? decoration;
  Map<int, MaterialStatesController> materialStates = {};


  AdminTable(
      {super.key,
      required this.controller,
      this.height = 50,
      this.fixedHeader = false,
      this.tableStyle,
      this.tableItemStyle,
      this.decoration});

  @override
  State<StatefulWidget> createState() => _AdminTable<T>();
}

class _AdminTable<T> extends State<AdminTable> {
  late LinkedScrollControllerGroup _controllers;
  ScrollController? left;
  ScrollController? right;
  late ScrollController none;
  late ScrollController noneHorizontal;
  bool start = false;
  bool end = false;
  late AdminTableStyle tableStyle;
  late AdminTableItemStyle tableItemStyle;

  @override
  void initState() {
    _controllers = LinkedScrollControllerGroup();
    none = _controllers.addAndGet();
    noneHorizontal = ScrollController();
    noneHorizontal.addListener(_horizontal);
    widget.controller.addListener(updateView);
    super.initState();
  }

  void _horizontal() {
    setState(() {
      if (noneHorizontal.position.maxScrollExtent <=
          noneHorizontal.offset + 5) {
        if (end) {
          setState(() {
            end = false;
          });
        }
      } else {
        if (!end) {
          end = true;
        }
      }
      if (noneHorizontal.position.minScrollExtent >=
          noneHorizontal.offset - 5) {
        if (start) {
          start = false;
        }
      } else {
        if (!start) {
          start = true;
        }
      }
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateView);
    left?.dispose();
    right?.dispose();
    none.dispose();
    noneHorizontal.removeListener(_horizontal);
    noneHorizontal.dispose();
    for (var value in widget.materialStates.values) {
      value.dispose();
    }
    widget.materialStates.clear();
    super.dispose();
  }

  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  _TableCell getHeader(FixedDirection direction) {
    return _TableCell<T>(
      materialStatesController: MaterialStatesController(),
      index: -1,
      tableItemStyle: tableItemStyle,
      tableStyle: tableStyle,
      data: null,
      children: widget.controller.getItem(fixedDirection: direction),
    );
  }

  Tuple2<double, Widget> getViewInFixed(FixedDirection fixedDirection) {
    if (!widget.controller.fixed(fixedDirection)) {
      return Tuple2(0, Container());
    }
    double width = 0;
    List<AdminTableItem> item =
        widget.controller.getItem(fixedDirection: fixedDirection);
    for (var element in item) {
      width += element.width;
    }

    _TableCell header = getHeader(fixedDirection);
    List<Widget> data = [];
    if (widget.fixedHeader) {
      data.add(SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate.fixedHeight(
              height: widget.height, child: header)));
    } else {
      data.add(SliverFixedExtentList(
        itemExtent: widget.height,
        delegate: SliverChildBuilderDelegate((context, index) {
          return header;
        }, childCount: 1),
      ));
    }
    data.add(SliverFixedExtentList(
      itemExtent: widget.height,
      delegate: SliverChildBuilderDelegate((context, index) {
        if (!widget.materialStates.containsKey(index)) {
          widget.materialStates[index] = MaterialStatesController();
          widget.materialStates[index]!.removeListener(updateView);
          widget.materialStates[index]!.addListener(updateView);
        }
        return _TableCell<T>(
          materialStatesController: widget.materialStates[index]!,
          tableStyle: tableStyle,
          tableItemStyle: tableItemStyle,
          children: item,
          index: index,
          data: widget.controller.ofData(index),
        );
      }, childCount: widget.controller.ofCount()),
    ));
    width == 0 ? 100 : width;
    ScrollBehavior? behavior;
    if (fixedDirection == FixedDirection.none && right != null) {
      behavior = const ScrollBehavior().copyWith(scrollbars: false);
    } else if (fixedDirection == FixedDirection.left) {
      behavior = const ScrollBehavior().copyWith(scrollbars: false);
    } else {}

    BoxDecoration? boxDecoration;

    if (fixedDirection == FixedDirection.left && start) {
      boxDecoration = BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, 0), //阴影xy轴偏移量
              blurRadius: 10.0, //阴影模糊程度//阴影扩散程度
              spreadRadius: -10) //阴影模糊大小
        ],
      );
    }

    if (fixedDirection == FixedDirection.right && end) {
      boxDecoration = BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, 0), //阴影xy轴偏移量
              blurRadius: 10.0, //阴影模糊程度//阴影扩散程度
              spreadRadius: -10) //阴影模糊大小
        ],
      );
    }
    return Tuple2(
        width,
        SizedBox(
          width: width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: fixedDirection == FixedDirection.right ? 0 : null,
                  right: fixedDirection == FixedDirection.left ? 0 : null,
                  child: Container(
                    decoration: boxDecoration,
                  )),
              SizedBox(
                width: width,
                child: CustomScrollView(
                  scrollBehavior: behavior,
                  controller: fixedDirection == FixedDirection.left
                      ? left
                      : (fixedDirection == FixedDirection.right ? right : none),
                  scrollDirection: Axis.vertical,
                  slivers: data,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    tableStyle = widget.tableStyle ?? AdminColors().get().tableStyle;
    tableItemStyle =
        widget.tableItemStyle ?? AdminColors().get().tableItemStyle;

    return LayoutBuilder(builder: (context, size) {
      var leftRightWidth = 0.0;

      Widget? leftWidget;
      Widget? rightWidget;
      Widget? noneWidget;

      if (widget.controller.fixed(FixedDirection.left)) {
        left ??= _controllers.addAndGet();
        var value = getViewInFixed(FixedDirection.left);
        leftRightWidth += value.item1;
        leftWidget = value.item2;
      }

      this.right ??= _controllers.addAndGet();
      var right = getViewInFixed(FixedDirection.right);
      leftRightWidth += right.item1;

      if (widget.controller.fixed(FixedDirection.none)) {
        var value = getViewInFixed(FixedDirection.none);
        var width = value.item1;
        if (leftRightWidth + width > size.maxWidth) {
          width = size.maxWidth - leftRightWidth;
          leftRightWidth = size.maxWidth;
          end = true;
        } else {
          leftRightWidth += width;
        }

        noneWidget = SizedBox(
          width: width,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerSignal: (e) {
              if (e is PointerScrollEvent) {}
            },
            child: Scrollbar(
              controller: noneHorizontal,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: noneHorizontal,
                // dragStartBehavior: DragStartBehavior.down,
                scrollDirection: Axis.horizontal,
                child: value.item2,
              ),
            ),
          ),
        );
      }
      if (widget.controller.fixed(FixedDirection.right)) {
        rightWidget = right.item2;
      }
      List<Widget> stackChildren = [];
      if (leftWidget != null) {
        stackChildren.add(noneWidget!);

        stackChildren.add(Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: leftWidget,
        ));
      }
      if (rightWidget != null) {
        stackChildren.add(Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: rightWidget,
        ));
      }
      return Container(
        width: size.maxWidth,
        height: size.maxHeight,
        decoration: widget.decoration,
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: leftRightWidth,
          height: size.maxHeight,
          child: Stack(
            alignment: Alignment.center,
            children: stackChildren,
          ),
        ),
      );
    });
  }
}

class _TableCell<T> extends StatefulWidget {
  final List<AdminTableItem> children;
  final int index;
  final T? data;
  final AdminTableItemStyle tableItemStyle;
  final AdminTableStyle tableStyle;
  final MaterialStatesController materialStatesController;

  const _TableCell(
      {super.key,
      required this.children,
      required this.index,
      required this.data,
      required this.tableItemStyle,
      required this.tableStyle,
      required this.materialStatesController});

  @override
  State<StatefulWidget> createState() => _TableCellState<T>();
}

class _TableCellState<T> extends State<_TableCell<T>> {
  @override
  Widget build(BuildContext context) {
    Color itemColor = widget.tableItemStyle.backgroundColor
        .resolve(widget.materialStatesController.value);
    if (itemColor == Colors.transparent && widget.tableStyle.stripe != null) {
      itemColor = widget.tableStyle.stripe!(widget.index);
    }
    BoxDecoration? boxDecoration;
    if (widget.tableStyle.border) {
      BorderSide borderSide = BorderSide(
          color: widget.tableStyle.borderColor,
          width: widget.tableStyle.borderWidth);
      boxDecoration = BoxDecoration(
          color: itemColor,
          border: Border(
            left: widget.tableStyle.borderType == BorderType.left ||
                    widget.tableStyle.borderType == BorderType.all
                ? borderSide
                : BorderSide.none,
            right: widget.tableStyle.borderType == BorderType.right ||
                    widget.tableStyle.borderType == BorderType.all
                ? borderSide
                : BorderSide.none,
            bottom: widget.tableStyle.borderType == BorderType.bottom ||
                    widget.tableStyle.borderType == BorderType.all
                ? borderSide
                : BorderSide.none,
            top: widget.tableStyle.borderType == BorderType.top ||
                    widget.tableStyle.borderType == BorderType.all
                ? borderSide
                : BorderSide.none,
          ));
    } else {
      boxDecoration = BoxDecoration(color: itemColor);
    }
    return Row(
      children: widget.children.map((e) {
        return SizedBox(
          width: e.width,
          height: double.infinity,
          child: MouseRegion(
            onExit: (e) {
              widget.materialStatesController
                  .update(MaterialState.hovered, false);
            },
            onEnter: (e) {
              if (!e.synthesized) {
                widget.materialStatesController
                    .update(MaterialState.hovered, true);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: boxDecoration,
              child: e.itemView(context, widget.index, widget.data, e),
            ),
          ),
        );
      }).toList(),
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
