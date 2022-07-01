import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class EcoStyle {
  static const boldStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const Kblack = Color(0xFF777A95);
const Kgreen = Color(0xFF129A7f);
const KBlue = Color.fromARGB(255, 40, 40, 226);
const Korange = Color(0xFFFFA873);
const Kpurple = Color(0xFFA079EC);
const Kgreenacent = Color(0xFFF7F7F7);
const Kgrey = Color(0xFFEEEEF0);
const kPrimarycolor = Color(0xFF00BF6D);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kSecondarycolor = Color(0xFFFE9901);
const Kerrorcolor = Color(0xFFF03738);

const kDefaultPadding = 20.0;
const kSpacingUnit = 10;

var ktitlestyle = TextStyle(
  color: Kblack,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
var ksubtitlestyle = TextStyle(
  color: Kblack,
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
);
