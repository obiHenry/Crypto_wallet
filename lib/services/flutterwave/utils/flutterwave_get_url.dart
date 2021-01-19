import 'package:flutter/foundation.dart';

final String proxyUrl = 'https://cors-anywhere.herokuapp.com/';
String getUrl(String mainUrl) {
  return kIsWeb ? proxyUrl + mainUrl : mainUrl;
}
