import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/routes/resource_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../core/utils/constants.dart';
import '../js/home_js.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? webViewController;
  bool isLoading = false;
  String profileImage = '';
  String name='';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    webViewController = null;
    super.dispose();
  }

void injectCookie(user) async {
    String userInfo = json.encode({
      'displayName': "Estiven Betancur",
      'photoURL': user.photoURL,
      'email': user.email,
    });

    String encodedUserInfo = Uri.encodeComponent(userInfo);
    Cookie cookie = Cookie(name:'user_info')
      ..path = '/'
      ..value= encodedUserInfo
      ..isHttpOnly = false
      ; 

    await CookieManager.instance().setCookie(
      url: WebUri(Constants.homeUrl),
      name: cookie.name,
      value: cookie.value,
      domain:  'qcrack-auth.web.app',
      path: cookie.path.toString(),
      isHttpOnly: cookie.isHttpOnly,
      isSecure: cookie.isSecure,
    );

    webViewController?.loadUrl(
      urlRequest: URLRequest(url: WebUri(Constants.homeUrl)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(3.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey",
                        style: textBigBold22(secondColor),
                      ),
                      Text(
                        "Where do you go?",
                        style: textBlackStyleSubTitle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: user?.photoURL != null && user!.photoURL!.isNotEmpty
                            ? Image.network(
                                width: 20.w,
                                user.photoURL!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                userProfile,
                                width: 20.w,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
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
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      // any code;
                      return NavigationActionPolicy.ALLOW;
                    },
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                      // Add JavaScriptHandler
                      webViewController!.addJavaScriptHandler(
                        handlerName: 'flutterHandler',
                        callback: (args) {
                          log('Evento recibido de JavaScript: $args');
                          return null;
                        },
                      );

                       injectCookie(user);
                    },
                    onUpdateVisitedHistory: (controller, url, androidIsReload) async{
                     
                    },
                    onLoadStart: (controller, url) {
                      log("Started loading: $url");
                      if (mounted) {
                        setState(() {
                          isLoading = true;
                        });
                      }
                    },
                    onLoadStop: (controller, url) {
                      log("Finished loading: $url");
                      webViewController!
                          .evaluateJavascript(source: homejsScript)
                          .then((_) {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    },
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: scaffoldColor,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
