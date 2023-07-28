import 'package:flutter/material.dart';

import 'screens/editNote.dart';
import 'screens/MyHomePage.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      //themeMode: MediaQuery.maybePlatformBrightnessOf(context) != Brightness.light ?ThemeMode.dark:ThemeMode.light,
      themeMode: ThemeMode.dark,/*Debug only un commit the above line and delete this line TODO*/
      debugShowMaterialGrid: false,
      theme: ThemeData(
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

      home: const MyHomePage(title: 'Note Files'),
      routes: {
        EditNote.routeName: (_) => const EditNote(),
      },
    );
  }
}

