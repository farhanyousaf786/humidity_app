

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {

     return Scaffold(

       body: WebView(
        initialUrl: 'https://sites.google.com/view/roomtemapp/home',
        onWebViewCreated: (WebViewController webViewController){

          _controller.complete(webViewController);
        },
    ),
     );
  }
}
