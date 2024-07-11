import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:qcracks_mobile/core/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/menu/menu_bottom_page.dart';
import '../../../core/routes/resource_icons.dart';
import '../../../core/theme/colors.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/auth";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late WebViewController controller;
  InAppWebViewController? webViewController;

  bool isLoading = true;
  bool triedToReload = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(loginImage),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: EdgeInsets.all(3.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 9.h,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        initialSettings: InAppWebViewSettings(
                            userAgent: 'random', transparentBackground: true),
                        initialUrlRequest: URLRequest(
                          url: WebUri(Constants.authUrl),
                        ),
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
                        onLoadStart: (controller, url) {
                          log("Started loading: $url");
                          setState(() {
                            isLoading = true;
                          });
                        },
                        onLoadStop: (controller, url) async {
                          log("Finished loading: $url");
                          CookieManager cookieManager =
                              CookieManager.instance();
                          // get cookies
                          List<Cookie> cookies =
                              await cookieManager.getCookies(url: url!);
                          Cookie? userDataCookie = cookies.firstWhere(
                              (cookie) => cookie.name == 'connect.sid',
                              orElse: () => Cookie(name: ''));
                          if (userDataCookie.name.isNotEmpty) {
                            Navigator.pushNamed(
                                // ignore: use_build_context_synchronously
                                context,
                                MenuBottomPage.routeName);
                          } else {
                            if (!triedToReload) {
                              setState(() {
                                triedToReload =
                                    true; 
                              });
                              await webViewController?.webStorage.localStorage
                                  .clear();
                              await CookieManager.instance().deleteAllCookies();
                              controller.loadUrl(
                                  urlRequest: URLRequest(
                                      url: WebUri(Constants.authUrl)));
                            }

                       
                          }
                      setState(() {
                            isLoading = false;
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
        ),
      ),
    );
  }
}
