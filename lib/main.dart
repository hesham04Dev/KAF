import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import '../isarCURD.dart';

import 'screens/FolderPage.dart';
import 'screens/editNote.dart';
import 'translations/translations.dart';

late final isar;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isar =  IsarService();
  await isar.openDB();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.dark);
  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    Map<String, String> locale;
    String lang = "${Platform.localeName[0]}${Platform.localeName[1]}";
    if (Translations.supportedLocales.contains(lang)) {
      locale = Translations.mapLocales[lang]!;
    } else {
      locale = Translations.mapLocales["en"]!;
    }
    if (lang == "ar")
      isRtl = true;
    else
      isRtl = false;
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
         //themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,

        /*Debug only un commit the above line and delete this line TODO*/
        debugShowMaterialGrid: false,
        theme: ThemeData(
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              iconColor: MaterialStatePropertyAll(
                lightColorScheme?.onPrimary ??
                    _defaultLightColorScheme.onPrimary,
              )
            )
          ),
            dialogBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            dividerTheme: DividerThemeData(color: Colors.black),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
                        color: Colors.black,
                        fontFamily: "Cairo",
                        fontSize: 19)))),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(shape: const CircleBorder()),
            iconTheme: IconThemeData(
              color:
                  lightColorScheme?.primary ?? _defaultLightColorScheme.primary,
            ),
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
            fontFamily: "Cairo",
            appBarTheme: AppBarTheme(
              backgroundColor:
                  lightColorScheme?.primary ?? _defaultLightColorScheme.primary,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: lightColorScheme?.onPrimary ??
                    _defaultLightColorScheme.onPrimary,
              ),
              centerTitle: true,
            ),
            drawerTheme: DrawerThemeData(
              backgroundColor: Colors.white,
            )),
        darkTheme: ThemeData(
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(
                    darkColorScheme?.onPrimary ??
                        _defaultDarkColorScheme.onPrimary,
                  )
              )
          ),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white10,
              hintStyle: TextStyle(color: Colors.white70)),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                      color: darkColorScheme?.primary ??
                          _defaultDarkColorScheme.primary,
                      fontFamily: "Cairo",
                      fontSize: 19)))),
          scaffoldBackgroundColor: Color.fromARGB(255, 50, 50, 50),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(shape: const CircleBorder()),
          iconTheme: IconThemeData(
            color: darkColorScheme?.primary ?? _defaultDarkColorScheme.primary,
          ),
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
          fontFamily: "Cairo",
          appBarTheme: AppBarTheme(
            backgroundColor:
                darkColorScheme?.primary ?? _defaultDarkColorScheme.primary,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: darkColorScheme?.onPrimary ??
                  _defaultDarkColorScheme.onPrimary,
            ),
            centerTitle: true,
          ),
        ),
        home: Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child:FolderPage(locale: locale, isRtl: isRtl, db: isar)),
        routes: {
          EditNote.routeName: (_) => Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: EditNote(locale: locale, db: isar , isRtl: isRtl)),
        },
      );
    });
  }
}
class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  Future<String> fetchData() async {
    // Simulating an asynchronous operation
    await Future.delayed(Duration(seconds: 2));
    return 'Data loaded';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Loading Example')),
      body: FutureBuilder<String>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Show loading icon
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('Data: ${snapshot.data}'),
            );
          }
        },
      ),
    );
  }
}
