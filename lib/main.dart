import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'screens/MyHomePage.dart';
import 'screens/editNote.dart';
import 'translations/codegen_loader.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        assetLoader: CodegenLoader(),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.green, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {

    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
       // themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,

        /*Debug only un commit the above line and delete this line TODO*/
        debugShowMaterialGrid: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            print(locale);
            return locale;
          }
          return Locale('en');
        },
        locale: context.locale,
        theme: ThemeData(
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
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white10,
            hintStyle: TextStyle(
              color: Colors.white70
            )
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                      color: darkColorScheme?.primary ?? _defaultDarkColorScheme.primary,
                      fontFamily: "Cairo",
                      fontSize: 19)))),
          scaffoldBackgroundColor:Color.fromARGB(255, 50, 50, 50),
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
        home: const MyHomePage(),
        routes: {
          EditNote.routeName: (_) => const EditNote(),
        },
      );
    });
  }
}
