import 'package:flutter/material.dart';

final ThemeData theme = _buildShrineTheme();

const kShrineErrorRed = const Color(0xFFC5032B);
const kShrineSurfaceWhite = const Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;
const kShrineAltDarkGrey = const Color(0xFF414149);
const kShrineAltYellow = const Color(0xFFFFCF44);
const kShrinePink100 = const Color(0xFFFEDBD0);

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    accentColor: kShrineAltDarkGrey,
    primaryColor: kShrineAltDarkGrey,
    buttonColor: kShrineAltYellow,
    scaffoldBackgroundColor: kShrineAltDarkGrey,
    cardColor: kShrineAltDarkGrey,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
  );
}
