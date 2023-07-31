import 'dart:convert';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/palettes/core_palette.dart';

import 'screens/MyHomePage.dart';
import 'screens/editNote.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _defaultLightColorScheme =
  ColorScheme.fromSwatch(primarySwatch: Colors.orange,brightness:Brightness.light );

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.orange, brightness: Brightness.dark);
  /*Future<CorePalette?> colorPalette() async {
    return await DynamicColorPlugin.getCorePalette() as CorePalette?;
  }*/

  @override
  Widget build(BuildContext context) {
    //CorePalette corePalette =  colorPalette() as CorePalette?;
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {

      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      /*Debug only un commit the above line and delete this line TODO*/
      debugShowMaterialGrid: false,
/*
      theme: ThemeData(
       /* colorScheme: (corePalette == null)
            ? ColorScheme.fromSeed(
                seedColor: Colors.orangeAccent,
                brightness: MediaQuery.maybePlatformBrightnessOf(context) ??
                    Brightness.light)
            : ColorScheme(
                primary:  corePalette!.primary.get(40) as Color,
                onPrimary: corePalette!.primary.get(100) as Color,
                primaryContainer: corePalette!.primary.get(90) as Color,
                onPrimaryContainer: corePalette!.primary.get(10) as Color,
                secondary: corePalette!.secondary.get(40) as Color,
                onSecondary: corePalette!.secondary.get(100) as Color,
                secondaryContainer: corePalette!.secondary.get(90) as Color,
                onSecondaryContainer: corePalette!.secondary.get(10) as Color,
                tertiary: corePalette!.tertiary.get(40) as Color,
                onTertiary: corePalette!.tertiary.get(100) as Color,
                tertiaryContainer: corePalette!.tertiary.get(90) as Color,
                onTertiaryContainer: corePalette!.tertiary.get(10) as Color,
                error: corePalette!.error.get(40) as Color,
                onError: corePalette!.error.get(100) as Color,
                errorContainer: corePalette!.error.get(90) as Color,
                onErrorContainer: corePalette!.error.get(10) as Color,
                background: corePalette!.neutral.get(99) as Color,
                onBackground: corePalette!.neutral.get(10) as Color,
                surface: corePalette!.neutral.get(99) as Color,
                onSurface: corePalette!.neutral.get(10) as Color,
                surfaceVariant: corePalette!.neutralVariant.get(90) as Color,
                onSurfaceVariant: corePalette!.neutralVariant.get(30) as Color,
                outline: corePalette!.neutralVariant.get(50) as Color,
                shadow: corePalette!.neutral.get(0) as Color,
                inverseSurface: corePalette!.neutral.get(20) as Color,
                inversePrimary: corePalette!.primary.get(80) as Color,
                brightness: MediaQuery.maybePlatformBrightnessOf(context) ??
                    Brightness.light,
              ),*/

        colorScheme: lightColorScheme ?? _defaultLightColorScheme,
        fontFamily: "Cairo",
        brightness: MediaQuery.maybePlatformBrightnessOf(context),
        /*appBarTheme: const AppBarTheme(
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 30,
                color: Colors.black87)),*/
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          centerTitle: true,
          /* shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(200)),
            )*/
        ),
        useMaterial3: true,
      ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),*/
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
          fontFamily: "Cairo",
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            centerTitle: true,

          ),
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
          fontFamily: "Cairo",
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            centerTitle: true,

          ),

        ),
      home: const MyHomePage(title: 'Note Files'),
      routes: {
        EditNote.routeName: (_) => const EditNote(),
      },
    );

  });
}
}
