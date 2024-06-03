import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0A74DA); // Deep blue
const kPrimaryLightColor = Color(0xFF63A4FF); // Light blue
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0A74DA), Color(0xFF63A4FF)],
);
const kSecondaryColor = Color(0xFF979797); // Neutral grey
const kAccentColor = Color(0xFFFFA726); // Bright orange
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Additional constants for padding and spacing
const kDefaultPadding = 20.0;

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

const kSubtitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kSecondaryColor,
);

const kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kAppBarTitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// BoxShadow for elevation
const kBoxShadow = BoxShadow(
  color: Colors.black26,
  blurRadius: 10,
  offset: Offset(0, 2),
);

// BorderRadius for rounded elements
const kBorderRadius = BorderRadius.all(Radius.circular(10));
