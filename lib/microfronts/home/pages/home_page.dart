import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
    super.dispose();
   
  }

  @override
  Widget build(BuildContext context) {
    
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
                        "Hey $name",
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
                          child: profileImage != ''?   Image.network(
                            width: 20.w,
                            profileImage,
                            fit: BoxFit.cover,
                          ): Image.asset(
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
                    initialUrlRequest: URLRequest(
                      url: WebUri(Constants.homeUrl),
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
                    onUpdateVisitedHistory: (controller, url, androidIsReload) async{
                      CookieManager cookieManager =
                              CookieManager.instance();
                          // get cookies
                          List<Cookie> cookies =
                              await cookieManager.getCookies(url: url!);
                          Cookie? userDataCookie = cookies.firstWhere(
                              (cookie) => cookie.name == 'userData',
                              orElse: () => Cookie(name: ''));
                          if (userDataCookie.name.isNotEmpty) {
                            String decodedValue =
                                Uri.decodeComponent(userDataCookie.value);
                            log('Cookie userData: $decodedValue');
                            Map<String, dynamic> user = json.decode(decodedValue);
                            setState(() {
                               name = user['displayName'].split(' ')[0];
                               profileImage=user['photo'];
                            });
                    
                          } else {
                            log('Cookie userData no encontrada');
                          }


                      // if (url.toString().contains("hotel")) {
                      //   Navigator.pushReplacementNamed(context, DestinationPage.routeName,
                      //       arguments: url.toString());
                      //   log('entró');
                      //   return;
                      // }
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
                          .evaluateJavascript(source: homejsScript)
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

  void getAllCookies() async {
  CookieManager cookieManager = CookieManager.instance();
  final url = WebUri(Constants.homeUrl);

  // get cookies
   await cookieManager.getCookies(url: url);
}
}
