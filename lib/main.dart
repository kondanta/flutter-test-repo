import 'package:flutter/material.dart';
import 'package:learner_app/home_page.dart';
import 'package:learner_app/colors.dart';
import 'package:flutter_villains/villain.dart';

void main() {
  runApp(new MaterialApp(
    title: "MangApplizer",
    home: HomePage(),
    navigatorObservers: [new VillainTransitionObserver()],
    theme: theme,
  ));
}
