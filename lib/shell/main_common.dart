import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../core/routes/page_generator.dart';
import '../core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/splash_page.dart';

class MainCommon extends StatelessWidget {
  const MainCommon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QUIND',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
           Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: appTheme,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: PageClassGenerator.getNamedScreen,
      );
    });
  }
}
