import 'dart:ui';
import 'package:bc_admin/ui/themes/base_theme.dart';

class LightTheme extends BaseTheme {
  @override
  Color get backgroundColor => const Color.fromRGBO(255, 255, 255, 1);

  @override
  Color get primaryAccent => const Color.fromRGBO(235, 235, 235, 1);

  @override
  Color get secondaryColor => const Color.fromARGB(255, 0, 100, 255);

  @override
  Color get cardColor => const Color.fromARGB(255, 247, 247, 249);

  @override
  Color get primaryContent => const Color.fromRGBO(0, 0, 0, 1);

  @override
  Brightness get brightness => Brightness.light;
}
