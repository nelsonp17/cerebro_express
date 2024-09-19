import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

int generarNumeroAleatorio() {
  final random = Random();
  return random.nextInt(5) + 1;
}
/**
 * 
 * 
 * 
 * bool _isConnected = false;
 * 
  *@override
  *void initState() {
  *  super.initState();
  *  checkInternetConnection().then((isConnected) {
  *    setState(() {
  *      _isConnected = isConnected;
  *    });
  *  });
  *}

  *
 */

Future<String> getPlatform() async {
  if (kIsWeb) {
    return "web";
  }

  String platform = switch (defaultTargetPlatform) {
    TargetPlatform.android => "android",
    TargetPlatform.fuchsia => "Dispositivo no soportado",
    TargetPlatform.iOS => "ios",
    TargetPlatform.linux => "linux",
    TargetPlatform.macOS => "macOS",
    TargetPlatform.windows => "windows",
  };

  return platform;
}
