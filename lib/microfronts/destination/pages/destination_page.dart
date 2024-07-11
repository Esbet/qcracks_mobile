import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qcracks_mobile/microfronts/destination/js/destination_js.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../core/components/simple_appbar.dart';
import '../../../core/theme/colors.dart';

class DestinationPage extends StatefulWidget {
  static const routeName = "/destination";
  const DestinationPage({super.key, required this.route});
  final String route;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  late WebViewController controller;
  InAppWebViewController? webViewController;
  InAppWebViewController? webViewController2;
  bool isLoading = false;
  bool hasPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: simpleAppBar(context, 'Destination', null),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: InAppWebView(
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        clearCache: true,
                        safeBrowsingEnabled: true,
                        useShouldOverrideUrlLoading: true,
                        supportMultipleWindows: true,
                        transparentBackground: true,
                      ),
                      initialUrlRequest: URLRequest(
                        url: WebUri(widget.route),
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
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {
                        if (url.toString().contains("calendar") &&
                            !hasPressed) {
                          setState(() {
                            hasPressed = true;
                          });
                          webViewController?.goBack();
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Padding(
                                  padding: EdgeInsets.all(7.w),
                                  child: Column(
                                    children: [
                                      Expanded(
                                    child: InAppWebView(
                                      initialSettings: InAppWebViewSettings(
                                        clearCache: false,
                                        javaScriptEnabled: true,
                                        safeBrowsingEnabled: true,
                                        useShouldOverrideUrlLoading: true,
                                        supportMultipleWindows: true,
                                        transparentBackground: true,
                                      ),
                                      initialUrlRequest: URLRequest(
                                        url: WebUri(url.toString()),
                                      ),
                            
                                      onWebViewCreated: (controller) {
                                        webViewController2 = controller;
                                        // Añade el JavaScriptHandler
                                        webViewController2!.addJavaScriptHandler(
                                          handlerName: 'flutterHandler',
                                          callback: (args) {
                                            log('Evento recibido de JavaScript: $args');
                                            // Puedes hacer algo con los datos recibidos desde JavaScript
                                            return null;
                                          },
                                        );
                                      },
                                      onUpdateVisitedHistory:
                                          (controller, url, androidIsReload) {
                                       
                                      },
                                      onLoadStart: (controller, url) {
                                        log("Started loading: $url");
                                       
                                      },
                                      onLoadStop: (controller, url) {
                                        log("Finished loading: $url");
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 2.h,)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).then((value) {
                            // Este código se ejecutará después de que se cierre el ModalBottomSheet
                            hasPressed = false;
                            // Aquí puedes poner cualquier otra lógica que quieras ejecutar después de cerrar el modal
                          });
                          return;
                        }
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
                            .evaluateJavascript(source: destinationjsScript)
                            .then((_) {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      },
                    ),
                  ),
                  if (isLoading)
                    Container(
                      color: scaffoldColor,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                        ],
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
