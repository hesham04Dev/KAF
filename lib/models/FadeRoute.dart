import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  FadeRoute({required super.pageBuilder}) : super(
    transitionsBuilder:(_, a, __, c) =>
        FadeTransition(opacity: a, child: c),
  );
}