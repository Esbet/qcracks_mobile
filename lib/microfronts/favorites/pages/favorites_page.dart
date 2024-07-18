import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../core/theme/colors.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static const routeName = "/";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

    InAppWebViewController? webViewController;
  bool hasNavigated = false;
  bool isLoading = true;

  @override
void dispose() {

  super.dispose();
}


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
           
          
          ],
        ),
      ),
    );
  }
}
