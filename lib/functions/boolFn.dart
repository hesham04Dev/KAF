import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

bool isDarkMode(context) {
  return MediaQuery.maybePlatformBrightnessOf(context) == Brightness.dark;

}
bool isRTL(String text,bool isRtl) {
  if(text.isEmpty ) {return isRtl;}
  return intl.Bidi.detectRtlDirectionality(text);
}
