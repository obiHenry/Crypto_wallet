import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<bool> checkInternet() async {
  if (!kIsWeb) {
    try {
      final result = await InternetAddress.lookup('google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
          ? true
          : false;
    } on SocketException catch (_) {
      return false;
    }
  }
  return true;
}

Widget showLoader(bool isConnected) {
  return isConnected
      ? Center(
          child: SizedBox(
            child: CircularProgressIndicator(),
            height: 100,
            width: 100,
          ),
        )
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No internet connection',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 35,
            ),
            Image.asset('assets/images/no_internet.png'),
            SizedBox(
              height: 35,
            ),
            Text(
              'Pull down to refresh..',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
}
