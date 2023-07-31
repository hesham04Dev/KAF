import 'package:dynamic_color/dynamic_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'translations/codegen_loader.g.dart';
import 'screens/MyHomePage.dart';
import 'screens/editNote.dart';

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
      primarySwatch: Colors.orange, brightness: Brightness.light);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.orange, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {


    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        /*Debug only un commit the above line and delete this line TODO*/
        debugShowMaterialGrid: false,

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          }
          return Locale('ar');
        },
        locale: /*context.locale*/ Locale("ar"),
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
          fontFamily: "Cairo",
          appBarTheme:  AppBarTheme(
            backgroundColor: lightColorScheme?.primary ?? _defaultDarkColorScheme.primary,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,

            ),
            centerTitle: true,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: lightColorScheme?.background ?? Colors.orange[200],

          )
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
          fontFamily: "Cairo",
          appBarTheme:  AppBarTheme(
            backgroundColor: lightColorScheme?.primary ?? _defaultDarkColorScheme.primary,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
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

