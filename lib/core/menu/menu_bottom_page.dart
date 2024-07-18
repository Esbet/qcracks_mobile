import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../routes/navigators.dart';
import '../routes/navigators_observes.dart';
import '../routes/page_generator.dart';
import '../theme/colors.dart';

class MenuBottomPage extends StatefulWidget {
  const MenuBottomPage({super.key});

  static const routeName = '/menu';

  @override
  State<MenuBottomPage> createState() => _MenuBottomPageState();
}

class _MenuBottomPageState extends State<MenuBottomPage> {
  int _selectBottomTabIndex = 1;
  bool isvalid = false;

  final _controller = PageController();
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.jumpToPage(1);
      }
    });
    super.didChangeDependencies();
  }

  final pageBuilder = {
    0: PageClassGenerator().buildFavoritesTabPage,
    1: PageClassGenerator().buildHomeTabPage,
    2: PageClassGenerator().buildProfileTabPage,
  };

  final navigators = {
    0: favoritesTabNavigator,
    1: homeTabNavigator,
    2: profileTabNavigator,
  };

  final navigatorsObservers = {
    0: homeTabNavigatorObserver,
    1: homeTabNavigatorObserver,
    2: profileTabNavigatorObserver,
  };

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _handlerInternalNavigationInTab,
      child: Scaffold(
        extendBody: true,
        backgroundColor: firstColor,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            _tab(context, 0),
            _tab(context, 1),
            _tab(context, 2),
          ],
        ),
        bottomNavigationBar:
          Container(color: whiteColor, child: _bottomNavBar()),
      ),
    );
  }

  Future<bool> _handlerInternalNavigationInTab() async {
    final popped = await navigators[_selectBottomTabIndex]!.currentState!.maybePop();
    return !popped;
  }

  CurvedNavigationBar _bottomNavBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: _selectBottomTabIndex,
      height: 60.0,
      items: const <Widget>[
        Icon(Icons.favorite, size: 30, color: secondColor),
        Icon(Icons.home, size: 30, color: secondColor),
        Icon(Icons.person, size: 30, color: secondColor),
      ],
      color: Colors.white,
      buttonBackgroundColor: firstColor,
      backgroundColor: scaffoldColor,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _tabIconPressed(index);
        });
      },
    );
  }

  void _tabIconPressed(int index) {
    if (_selectBottomTabIndex != index) {
      setState(() {
        _selectBottomTabIndex = index;
      });
      _controller.jumpToPage(index);
    }
  }

  Widget _tab(BuildContext context, int tabIndex) {
    if (pageBuilder.containsKey(tabIndex)) {
      return CupertinoTabView(
        onGenerateRoute: pageBuilder[tabIndex],
        navigatorKey: navigators[tabIndex],
        navigatorObservers: [
          if (navigatorsObservers.containsKey(tabIndex))
            navigatorsObservers[tabIndex] as NavigatorObserver
        ],
      );
    } else {
      return const Material(
        child: Center(
          child: Text("Todavia no se ha aplicado"),
        ),
      );
    }
  }
}
