
import 'package:flutter/material.dart';


import '../../constants/colors.dart';
import '../../constants/sizes.dart';


class TOutlineButtonTheme {

  TOutlineButtonTheme._();

  //?: Light Theme
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: tSecondaryColor,
          // backgroundColor: tPrimaryColor,
          side: const BorderSide(color: tSecondaryColor),
          padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: const RoundedRectangleBorder(),
      )
  );

  //?: Dark Theme
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: tWhiteColor,
          // backgroundColor: tSecondaryColor,
          side: const BorderSide(color: tWhiteColor),
          padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
          shape: const RoundedRectangleBorder(),
      )
  );
}