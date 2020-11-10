import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



String formatPrice(price) {
  List split = price.toString().trim().split('.');
  String priceInt = split[0];
  String priceDec;
  if (priceInt.length < 4) {
    return  price;
  }
  if (split.length > 1) {
    priceDec = split[1];
  }
  String reversed = String.fromCharCodes(priceInt.runes
      .toList()
      .reversed); // to make price formatting start from behind
  final String value = reversed.replaceAllMapped(RegExp(r".{3}"), (match) {
    return "${match.group(0)},";
  });
  final String getPrice = String.fromCharCodes(value.runes.toList().reversed);

  return priceDec != null && priceDec != '00'
      ?  getPrice + '.' + priceDec
      :  getPrice;


}

// void currency() {
//     Locale locale = Localizations.localeOf(BuildContext());
//     var format = NumberFormat.simpleCurrency(locale: locale.toString());
//     print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
//     print("CURRENCY NAME ${format.currencyName}"); // USD
// }
