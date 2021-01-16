import 'package:flutter/material.dart';

/*const kTextFieldLabelStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  height: 2,
);*/

const kLotDetailTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  color: Colors.black,
  height: 2,
);

const kUIGradient = LinearGradient(
  begin: Alignment.topCenter,
  end:Alignment.bottomCenter,
  colors: [
    const Color(0xffDCE35B),
    const Color(0xff45B649),
  ],
);

const kTextStyle = TextStyle(
  color: const Color(0xFF1B5E20),
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

const kTextStyle2 = TextStyle(
  color: Colors.black,
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

const kEnabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 3.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kFocusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 3.0),
        // color: const Color(0xFF1B5E20), width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

/*const kFocusedErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);

const kErrorBorder= OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red, width: 2.0),
    borderRadius: const BorderRadius.all(
        Radius.circular(50.0))
);*/

const kColor = Color(0xFF1B5E20);

const kCardColor = const Color(0xff43a047);
// const Color(0xFF66BB6A);