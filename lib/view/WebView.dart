// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatelessWidget {
  final String Url;
  const WebViewScreen({
    required this.Url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(
            Icons.arrow_back_ios,
            color: primarycolor,
            size: 30,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: WebView(
        initialUrl: Url,
      ),
    );
  }
}
