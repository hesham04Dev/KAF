import 'package:flutter/material.dart';

bool isDarkMode(context) {
  return MediaQuery.maybePlatformBrightnessOf(context) == Brightness.dark;

}
