import 'package:flutter/material.dart';
import 'package:flutter_admin/style/colors.dart';
import 'package:flutter_admin/widgets/button/style.dart';
import 'package:flutter_admin/widgets/input/input.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/button/button.dart';
import '../base_views.dart';

class LoginView extends AdminView {
  LoginView({super.key});

  @override
  State<StatefulWidget> createState() => _LoginView();
}

class _LoginView extends AdminStateView<LoginView> {

  @override
  void initState() {
    logger.i("Init State Login");
    super.initState();
  }

  @override
  Widget? buildForLarge(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: AdminColors().get().backgroundColor,
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.6,
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 0),
                    spreadRadius: 50,
                    blurRadius: 50)
              ]),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          color: AdminColors().get().primaryBackgroundColor,
                          child: const Text(
                            "Flutter Admin",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 4,
                      child: FractionallySizedBox(
                        heightFactor: 1,
                        widthFactor: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          color: Colors.white,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            widthFactor: 1,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: AdminInput(
                                    hintText: "请输入邮箱",
                                    left: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  margin: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20),
                                  child: AdminInput(
                                    password: true,
                                    hintText: "请输入密码",
                                    left: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: const Icon(
                                        Icons.password,
                                        color: Colors.black12,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 50, right: 50),
                                  child: AdminButton(
                                    disabled: false,
                                    buttonSize: AdminButtonSize.medium,
                                    buttonShape: AdminButtonShape.circle,
                                    onTop: () {
                                      context.goNamed("Index");
                                    },
                                    text: "登录",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget? buildForMedium(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            // child: LoginBg(),
            color: AdminColors().get().backgroundColor,
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: size.maxWidth > size.maxHeight ? 0.8 : 0.4,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 0),
                      spreadRadius: 50,
                      blurRadius: 50)
                ],
              ),
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  color: Colors.white,
                  child: FractionallySizedBox(
                    heightFactor: size.maxWidth > size.minHeight ? 1 : 0.5,
                    widthFactor: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: const EdgeInsets.only(left: 40, right: 40),
                            child: AdminInput(
                              hintText: "请输入邮箱",
                              left: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            margin: const EdgeInsets.only(
                                left: 40, right: 40, top: 20),
                            child: AdminInput(
                              password: true,
                              hintText: "请输入密码",
                              left: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: const Icon(
                                  Icons.password,
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, left: 50, right: 50),
                            child: AdminButton(
                              loading: false,
                              buttonSize: AdminButtonSize.medium,
                              buttonShape: AdminButtonShape.circle,
                              onTop: () {
                                context.goNamed("Index");
                              },
                              text: "登录",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
