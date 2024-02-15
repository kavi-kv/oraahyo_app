
import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class TElevatedButtonTheme {

  TElevatedButtonTheme._();

  //?: Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: tWhiteColor,
      backgroundColor: taAccentColor,
      side: const BorderSide(color: tDarkBlue),
      shape: const RoundedRectangleBorder(),
      padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
    )
  );

  //?: Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: tWhiteColor,
        backgroundColor: tYellowish,
        side: const BorderSide(color: tYellowish),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: const RoundedRectangleBorder(),

    )
  );
}