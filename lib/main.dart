import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:note_files/homePageData.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/provider/PriorityProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'functions/isRtlTextDirection.dart';
import 'functions/restoreDb.dart';
import 'screens/FolderPage.dart';
import 'translations/translations.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await localRestoreDbIfRestoreButtonClicked();

  print(" ddlkfd j");
  await requiredData.db.openDB();

  homePageFolders = await requiredData.db.getFolders(null);
  homePageNotes = await requiredData.db.getNotes(null);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ListViewProvider()),
      ChangeNotifierProvider(create: (_) => PriorityProvider()),
      //ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    //print("My app building");
    String lang = "${Platform.localeName[0]}${Platform.localeName[1]}";
    if (Translations.supportedLocales.contains(lang)) {
      requiredData.set_locale = Translations.mapLocales[lang]!;
    } else {
      requiredData.set_locale = Translations.mapLocales["en"]!;
    }
    if (lang == "ar") {
      requiredData.set_isRtl = true;
    } else {
      requiredData.set_isRtl = false;
    }
    String chosenFont = "Noto"; /*this is the default font*/
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        //themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
            iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(
              lightColorScheme?.onPrimary ?? _defaultLightColorScheme.onPrimary,
            ))),
            dialogBackgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            dividerTheme: const DividerThemeData(color: Colors.black),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
                        color: Colors.black,
                        fontFamily: chosenFont,
                        fontSize: 19)))),
            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(shape: CircleBorder()),
            iconTheme: IconThemeData(
              color:
                  lightColorScheme?.primary ?? _defaultLightColorScheme.primary,
            ),
            colorScheme: lightColorScheme ?? _defaultLightColorScheme,
            useMaterial3: true,
            fontFamily: chosenFont,
            appBarTheme: AppBarTheme(
              backgroundColor:
                  lightColorScheme?.primary ?? _defaultLightColorScheme.primary,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: chosenFont,
                fontSize: 20,
                color: lightColorScheme?.onPrimary ??
                    _defaultLightColorScheme.onPrimary,
              ),
              centerTitle: true,
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: Colors.white,
            )),
        darkTheme: ThemeData(
          iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(
            darkColorScheme?.onPrimary ?? _defaultDarkColorScheme.onPrimary,
          ))),
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white10,
              hintStyle: TextStyle(color: Colors.white70)),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                      color: darkColorScheme?.primary ??
                          _defaultDarkColorScheme.primary,
                      fontFamily: chosenFont,
                      fontSize: 19)))),
          scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(shape: CircleBorder()),
          iconTheme: IconThemeData(
            color: darkColorScheme?.primary ?? _defaultDarkColorScheme.primary,
          ),
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
          fontFamily: chosenFont,
          appBarTheme: AppBarTheme(
            backgroundColor:
                darkColorScheme?.primary ?? _defaultDarkColorScheme.primary,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: chosenFont,
              fontSize: 20,
              color: darkColorScheme?.onPrimary ??
                  _defaultDarkColorScheme.onPrimary,
            ),
            centerTitle: true,
          ),
        ),
        home: Directionality(
            textDirection: isRtlTextDirection(requiredData.isRtl!),
            child: FolderPage()),
        /* routes: {
          EditNote.routeName: (_) => EditNote(),
          FolderPage.routeName: (_) => FolderPage(),
        },*/
      );
    });
  }
}
