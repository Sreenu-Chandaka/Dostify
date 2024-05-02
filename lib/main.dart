import 'package:dostify/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import "package:firebase_analytics/firebase_analytics.dart";

void main() {
  runApp( SplashScreen(onIntializationComplete: () {  }, key: UniqueKey(),));
}

