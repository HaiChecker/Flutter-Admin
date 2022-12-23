import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MainBody extends StatelessWidget{
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AutoRouter(),
    );
  }
}