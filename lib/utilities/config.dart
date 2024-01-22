import 'package:flutter/material.dart';

class Config{
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize{
    return screenWidth;
  }

  static get heightSize{
    return screenHeight;
  }

  static const spaceSmall = SizedBox(height: 25,);
  static final spaceMedium = SizedBox(height: screenHeight!* 0.05,);
  static final spaceBig = SizedBox(height: screenHeight!* 0.08,);

  static const outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.greenAccent),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.red),
  );

  static const primaryColor = Colors.pink;


  // static bool isCapitalRequired  = true;
  // static bool isSpecialCharacterRequired  = false;
  // static bool isNumericRequired  = false;
  // static bool isMaximumPasswordLengthRequired  = false;
  // static bool isUserNameDifferentAsEmail = false;
  // static bool isDateOfBirthRequired = false;
  // static bool isPhoneNumberRequired = false;
  // static bool isPhoneNumberUsedAsUserName = false;
  // static int minPasswordLength = 7;
  // static int maxPasswordLength = 15;

}

