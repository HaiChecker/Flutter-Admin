import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:logger/logger.dart';



class MenuTitle extends StatefulWidget {
  final AdminRouter router;

  const MenuTitle({super.key, required this.router});

  @override
  State<StatefulWidget> createState() => _MenuTitle();
}

class _MenuTitle extends State<MenuTitle> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      widget.router.addListener(updateView);
    });
  }

  @override
  void dispose() {
    widget.router.removeListener(updateView);
    super.dispose();
  }

  void updateView() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),child: Row(
      children: widget.router.tips.values.map((e) {
        bool selected = (e['id'] == widget.router.currentRoute?.id);
        String title = e['title'] as String;
        return InkWell(
          onTap: () {
            widget.router.goRouter.goNamed(e['name'] as String);
          },
          child: AnimatedContainer(
            margin: const EdgeInsets.only(right: 5),
            padding:
            const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2)),
                color: selected ? const Color(0xFF212330) : const Color(0xFF2B2D3C),
                border: Border.all(
                    width: 0.5,
                    color: selected ? const Color(0xFF2B2D3C) : const Color(0xFF212330))),
            duration: const Duration(milliseconds: 100),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 10,color:Colors.white),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),);
  }
}
