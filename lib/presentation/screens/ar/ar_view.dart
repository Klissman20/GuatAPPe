import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARScreen extends StatefulWidget {
  static const String name = 'ar-screen';
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController unityWidgetController;

  void onUnityCreated(controller) {
    this.unityWidgetController = controller;
    if(Platform.isAndroid) {
      const MethodChannel('unity.hack').invokeMethod("init");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Colors.transparent,
          child: UnityWidget(
            onUnityCreated: onUnityCreated,
            useAndroidViewSurface: true,
            fullscreen: true,
          ),
        ),
      ),
    );
  }
}
