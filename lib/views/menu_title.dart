import 'package:flutter/material.dart';
import 'package:flutter_admin/router/router_info.dart';
import 'package:go_router/go_router.dart';





class MenuTitle extends StatefulWidget {

  const MenuTitle({super.key});

  @override
  State<StatefulWidget> createState() => _MenuTitle();
}

class _MenuTitle extends State<MenuTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateView() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),child: Row(
      children: AdminRouter().tips.values.map((e) {
        bool selected = e.name == AdminRouter().currentRoute?.name;
        return InkWell(
          onTap: () {
            context.goNamed(e.name!);
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
                  e.title,
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
