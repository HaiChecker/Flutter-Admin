import 'package:flutter/material.dart';
import 'package:flutter_admin/widgets/loading/style.dart';

import '../widgets/button/admin_button_state_property.dart';
import '../widgets/button/style.dart';
import '../widgets/input/style.dart';
import '../widgets/menu/nav_menu_define.dart';
import '../widgets/table/style.dart';

class AdminColors extends ChangeNotifier {
  static final AdminColors _instance = AdminColors._internal();
  var theme = <String, AdminTheme>{};
  var themeKey = 'normal';

  factory AdminColors() {
    return _instance;
  }

  AdminColors._internal() {
    theme['normal'] = AdminTheme();
  }

  static AdminColors colors() {
    return AdminColors();
  }

  void changeTheme(String key) {
    themeKey = key;
    notifyListeners();
  }

  AdminTheme get() {
    return theme[themeKey]!;
  }

  static AdminTheme ofTheme() {
    return AdminColors().get();
  }
}

class AdminTheme {
  final NavMenuStyle navMenuStyle;
  final NavMenuItemStyle navMenuItemStyle;
  final NavMenuItemStyle navMenuItemStyle2;
  final NavMenuItemStyle navMenuItemStyle3;
  final AdminInputStyle inputStyle;
  final AdminButtonStateProperty<AdminButtonStyle> buttonStyle;
  final MaterialStateProperty<MouseCursor> clickMouse;
  final Color backgroundColor;
  final Color primaryBackgroundColor;
  final Color secondaryColor;
  final LoadingStyle loadingStyle;
  final AdminTableStyle tableStyle;
  final AdminTableItemStyle tableItemStyle;

  factory AdminTheme({NavMenuStyle? navMenuStyle,
    NavMenuItemStyle? navMenuItemStyle,
    NavMenuItemStyle? navMenuItemStyle2,
    NavMenuItemStyle? navMenuItemStyle3,
    AdminInputStyle? inputStyle,
    AdminButtonStateProperty<AdminButtonStyle>? buttonStyle,
    MaterialStateProperty<MouseCursor>? clickMouse,
    Color? backgroundColor,
    Color? primaryBackgroundColor,
    Color? secondaryColor,
    LoadingStyle? loadingStyle,
    AdminTableStyle? tableStyle,
    AdminTableItemStyle? tableItemStyle}) {
    backgroundColor = backgroundColor ?? const Color(0xFF212331);
    primaryBackgroundColor = primaryBackgroundColor ?? const Color(0xFF2B2D3D);

    secondaryColor = secondaryColor ?? const Color(0xFF9D9FA5);
    Color primaryColor = const Color(0xFF5A9CF8);
    Color infoColor = const Color(0xFF919398);
    Color successColor = const Color(0xFF7EC050);
    Color errorColor = const Color(0xFFE47470);
    Color warningColor = const Color(0xFFDCA551);
    // Menu Style
    navMenuStyle ??= NavMenuStyle(background: primaryBackgroundColor);

    // Menu Item Style
    Color navMenuItemColor = primaryBackgroundColor;
    Color navMenuItemOpenColor = const Color(0x99333545);
    Color navMenuItemHovered = const Color(0xFF333545);
    Color navMenuItemHovered2 = const Color(0xFF333545);
    navMenuItemStyle ??=
        NavMenuItemStyle(iconColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.white;
          }

          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          } else {
            return Colors.white70;
          }
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return navMenuItemHovered;
          }
          if (states.contains(MaterialState.selected)) {
            return navMenuItemColor;
          } else {
            return navMenuItemColor;
          }
        }), titleStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return const TextStyle(fontSize: 14, color: Colors.white);
          }
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(fontSize: 14, color: Colors.blue);
          } else {
            return const TextStyle(fontSize: 14, color: Colors.white70);
          }
        }));

    navMenuItemStyle2 ??=
        NavMenuItemStyle(iconColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.white;
          }

          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          } else {
            return Colors.white70;
          }
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return navMenuItemHovered2;
          }
          if (states.contains(MaterialState.selected)) {
            return navMenuItemOpenColor.withOpacity(0.9);
          } else {
            return navMenuItemOpenColor;
          }
        }), titleStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return const TextStyle(fontSize: 14, color: Colors.white);
          }
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(fontSize: 14, color: Colors.blue);
          } else {
            return const TextStyle(fontSize: 14, color: Colors.white70);
          }
        }));

    navMenuItemStyle3 ??=
        NavMenuItemStyle(iconColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.white;
          }

          if (states.contains(MaterialState.selected)) {
            return Colors.blue;
          } else {
            return Colors.white70;
          }
        }), backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return navMenuItemHovered2;
          }
          if (states.contains(MaterialState.selected)) {
            return navMenuItemOpenColor.withOpacity(0.9);
          } else {
            return navMenuItemOpenColor;
          }
        }), titleStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return const TextStyle(fontSize: 14, color: Colors.white);
          }

          if (states.contains(MaterialState.selected)) {
            return const TextStyle(fontSize: 14, color: Colors.blue);
          } else {
            return const TextStyle(fontSize: 14, color: Colors.white70);
          }
        }));

    inputStyle ??= AdminInputStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.transparent;
          } else if (states.contains(MaterialState.disabled)) {
            return Colors.black12;
          } else {
            return Colors.transparent;
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.black12;
          } else if (states.contains(MaterialState.hovered) &&
              states.contains(MaterialState.focused)) {
            return Colors.blue;
          } else if (states.contains(MaterialState.hovered) &&
              !states.contains(MaterialState.focused)) {
            return Colors.blue.withOpacity(0.5);
          } else if (states.contains(MaterialState.focused)) {
            return Colors.blue;
          } else {
            return Colors.black12;
          }
        }),
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 14, color: Colors.black45),
        ),
        hintTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, color: Colors.black26.withOpacity(0.5))));

    Color textColor = Colors.white;

    MaterialStateProperty<TextStyle> buttonText =
    MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return TextStyle(fontSize: 14, color: textColor.withOpacity(0.5));
      } else {
        return TextStyle(fontSize: 14, color: textColor);
      }
    });

    AdminButtonStyle primaryStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.pressed)) {
            return primaryColor;
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered)) {
            return primaryColor.withOpacity(0.8);
          } else {
            return primaryColor.withOpacity(0.9);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return primaryColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return primaryColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return primaryColor;
          } else {
            return primaryColor.withOpacity(0.5);
          }
        }));

    AdminButtonStyle infoStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return infoColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return infoColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return infoColor;
          } else {
            return infoColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return infoColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return infoColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return infoColor;
          } else {
            return infoColor.withOpacity(0.5);
          }
        }));

    AdminButtonStyle successStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return successColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return successColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return successColor;
          } else {
            return successColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return successColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return successColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return successColor;
          } else {
            return successColor.withOpacity(0.5);
          }
        }));

    AdminButtonStyle textStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }));

    AdminButtonStyle errorStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return errorColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return errorColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return errorColor;
          } else {
            return errorColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return errorColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return errorColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return errorColor;
          } else {
            return errorColor.withOpacity(0.5);
          }
        }));

    AdminButtonStyle warningStyle = AdminButtonStyle(
        textStyle: buttonText,
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return warningColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return warningColor;
          } else {
            return warningColor.withOpacity(0.5);
          }
        }),
        borderColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return warningColor.withOpacity(0.5);
          }
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.hovered) &&
                  !states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.28);
          } else if (states.contains(MaterialState.pressed)) {
            return warningColor.withOpacity(0.9);
          } else {
            return warningColor.withOpacity(0.5);
          }
        }));

    buttonStyle ??= AdminButtonStateProperty.resolveWith((states) {
      if (states.contains(AdminButtonType.primary)) {
        return primaryStyle;
      } else if (states.contains(AdminButtonType.info)) {
        return infoStyle;
      } else if (states.contains(AdminButtonType.success)) {
        return successStyle;
      } else if (states.contains(AdminButtonType.text)) {
        return textStyle;
      } else if (states.contains(AdminButtonType.error)) {
        return errorStyle;
      } else if (states.contains(AdminButtonType.warning)) {
        return warningStyle;
      } else {
        return textStyle;
      }
    });
    clickMouse ??=
        MaterialStateProperty.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return SystemMouseCursors.forbidden;
          }
          return SystemMouseCursors.basic;
        });

    loadingStyle ??= LoadingStyle(
        Colors.white.withOpacity(0.9),
            (context) =>
            CircularProgressIndicator(
              backgroundColor: backgroundColor?.withOpacity(0.6),
              color: backgroundColor,
            ));

    Color tableItem = const Color(0xFF333545);
    Color stripeColor = const Color(0xFF333544);
    tableStyle ??= AdminTableStyle(
        stripe: (index) {
          if (index == -1) {
            return primaryBackgroundColor!;
          } else {
            return index % 2 == 0 ? tableItem: stripeColor;
          }
        },
        border: true,
        borderColor: Colors.black26,
        borderWidth: 0.5,
        borderType: BorderType.bottom);

    const Color tableItemDisabled = Colors.black12;
    Color tableItemSelected = primaryBackgroundColor;
    Color tableItemHovered = const Color(0xFF313342);

    tableItemStyle ??= AdminTableItemStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return tableItemDisabled;
          }
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused)) {
            return tableItemHovered;
          }
          if (states.contains(MaterialState.selected)) {
            return tableItemSelected;
          }
          return Colors.transparent;
        }));

    return AdminTheme.raw(
        navMenuStyle,
        navMenuItemStyle,
        navMenuItemStyle2,
        navMenuItemStyle3,
        inputStyle,
        buttonStyle,
        clickMouse,
        backgroundColor,
        primaryBackgroundColor,
        secondaryColor,
        loadingStyle,
        tableStyle,
        tableItemStyle);
  }

  const AdminTheme.raw(this.navMenuStyle,
      this.navMenuItemStyle,
      this.navMenuItemStyle2,
      this.navMenuItemStyle3,
      this.inputStyle,
      this.buttonStyle,
      this.clickMouse,
      this.backgroundColor,
      this.primaryBackgroundColor,
      this.secondaryColor,
      this.loadingStyle,
      this.tableStyle,
      this.tableItemStyle);
}
