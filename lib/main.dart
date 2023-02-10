import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config.dart';
import 'ui/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup service locator
  await serviceLocator();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runZonedGuarded(
        () => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) async {
      /// Load SharedPref before load My App Widget
      SharedPreferences.getInstance().then((value) async {
        /// Register SharedPref
        initPrefManager(value);

        /// Run My App
        runApp(const MyApp());
      });
    }),
        (error, stackTrace) async {
      debugPrint(error.toString());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, _) => MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: 1,
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
          title: Strings.get.appName,
          theme: themeDefault,
          onGenerateRoute: (RouteSettings settings) {
            final routes = AppRoute.getRoutes(settings: settings);
            final WidgetBuilder? builder = routes[settings.name];
            return MaterialPageRoute(
              builder: (context) => builder!(context),
              settings: settings,
            );
          },
          initialRoute: AppRoute.splashPage,
        ),
      ),
    );
  }
}