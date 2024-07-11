import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/constants.dart';
import '../js/favorites_js.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  static const routeName = "/";

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late WebViewController controller;
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
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..addJavaScriptChannel('FlutterChannel',
    //       onMessageReceived: (JavaScriptMessage message) {
    //     log('Mensaje recibido de JavaScript: ${message.message}');
      
    //   })
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {
    //         log('Page started loading: $url');
    //         setState(() {
    //           isLoading = true;
    //         });
    //       },
    //       onPageFinished: (String url) {
    //         log('Page finished loading: $url');

    //         controller.runJavaScript(favoritesjsScript).then((_) {
    //           setState(() {
    //             isLoading = false;
    //           });
    //         });
    //       },
    //       onHttpError: (HttpResponseError error) {
    //         log('HTTP error: ${error.response}');
    //       },
    //       onNavigationRequest: (NavigationRequest request) {
    //         return NavigationDecision.navigate;
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //         log('Web resource error: ${error.description}');
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(Constants.trivagoFavoritesUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
           
            SizedBox(
              height: 2.h,
            ),
             Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialSettings: InAppWebViewSettings(
                      clearCache: false,
                      javaScriptEnabled: true,
                      safeBrowsingEnabled: true,
                      useShouldOverrideUrlLoading: true,
                      supportMultipleWindows: true,
                      transparentBackground: true,
                    ),
                    initialUrlRequest: URLRequest(
                      url: WebUri(Constants.trivagoFavoritesUrl),
                    ),
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      // any code;
                      return NavigationActionPolicy.ALLOW;
                    },
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      // Añade el JavaScriptHandler
                      webViewController!.addJavaScriptHandler(
                        handlerName: 'flutterHandler',
                        callback: (args) {
                          log('Evento recibido de JavaScript: $args');
                          // Puedes hacer algo con los datos recibidos desde JavaScript
                          return null;
                        },
                      );
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) {
                      
                    },
                    onLoadStart: (controller, url) {
                      log("Started loading: $url");
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onLoadStop: (controller, url) {
                      log("Finished loading: $url");

                      webViewController!
                          .evaluateJavascript(source: favoritesjsScript)
                          .then((_) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                  ),
                  if (isLoading)
                    Expanded(
                        child: Container(
                      color: scaffoldColor,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
