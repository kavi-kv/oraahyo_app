import 'package:flutter/material.dart';
import 'package:oraah_app/src/constants/color.dart';
import '../widget_themes/elevated_button_themes.dart';
import '../widget_themes/ouline_button_theme.dart';
import '../widget_themes/text_field_theme.dart';
import '../widget_themes/text_theme.dart';
import '../../constants/color.dart';

class TAppTheme {

  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldFieldTheme.lightInputDecorationTheme
  );
  static ThemeData darkTheme = ThemeData(
    primarySwatch:  Colors.yellow,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: TTextFormFieldFieldTheme.darkInputDecorationTheme
  );
}