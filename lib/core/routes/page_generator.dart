import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../microfronts/auth/pages/login_page.dart';
import '../../microfronts/destination/pages/destination_page.dart';
import '../../microfronts/favorites/pages/favorites_page.dart';
import '../../microfronts/home/pages/home_page.dart';
import '../../microfronts/profile/pages/profile_page.dart';
import '../../shell/pages/splash_page.dart';
import '../menu/menu_bottom_page.dart';

class PageClassGenerator {
  /// This method is for global  generics screens navigation routes
  static Route<dynamic> getNamedScreen(RouteSettings routeSettings) {
    Widget Function(BuildContext) builder;

    switch (routeSettings.name) {
      case SplashPage.routeName:
        builder = (context) => const SplashPage();
        break;

      case LoginPage.routeName:
        builder = (context) => const LoginPage();
        break;

      case MenuBottomPage.routeName:
        builder = (context) => const MenuBottomPage();
        break;

      //rutas de prueba
      default:
        builder = (context) => const Material(
              child: Center(child: Text("Todavia no se ha aplicado")),
            );
    }
    return _commonPageWrappper(
      routeSettings: routeSettings,
      builder: builder,
    );
  }

  Route<dynamic> buildHomeTabPage(
    RouteSettings routeSettings,
  ) {
    Widget Function(BuildContext) builder;

    switch (routeSettings.name) {
      case HomePage.routeName:
        builder = (context) => const HomePage();
        break;

      case DestinationPage.routeName:
        builder = (context) => DestinationPage(
              route: routeSettings.arguments as String,
            );
        break;
      default:
        builder = (context) => const Material(
              child: Center(child: Text("Todavia no se ha aplicado")),
            );
    }
    return _commonPageWrappper(
      routeSettings: routeSettings,
      builder: builder,
    );
  }

  Route<dynamic> buildProfileTabPage(
    RouteSettings routeSettings,
  ) {
    Widget Function(BuildContext) builder;

    switch (routeSettings.name) {
      case ProfilePage.routeName:
        builder = (context) => const ProfilePage();
        break;

      case LoginPage.routeName:
        builder = (context) => const LoginPage();
        break;

      default:
        builder = (context) => const Material(
              child: Center(child: Text("Todavia no se ha aplicado")),
            );
    }
    return _commonPageWrappper(
      routeSettings: routeSettings,
      builder: builder,
    );
  }

    Route<dynamic> buildFavoritesTabPage(
    RouteSettings routeSettings,
  ) {
    Widget Function(BuildContext) builder;

    switch (routeSettings.name) {
      case FavoritesPage.routeName:
        builder = (context) => const FavoritesPage();
        break;
        
      default:
        builder = (context) => const Material(
              child: Center(child: Text("Todavia no se ha aplicado")),
            );
    }
    return _commonPageWrappper(
      routeSettings: routeSettings,
      builder: builder,
    );
  }

  /// Configuration method to create our own navigation
  static Route<dynamic> _commonPageWrappper({
    required RouteSettings routeSettings,
    required Widget Function(BuildContext) builder,
  }) {
    return MaterialWithModalsPageRoute(
        settings: routeSettings,
        builder: (context) => Container(
              color: Colors.black.withOpacity(0.4),
              child: SafeArea(
                top: false,
                bottom: false,
                child: builder(context),
              ),
            ));
  }
}
