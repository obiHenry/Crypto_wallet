import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/widgets/constants.dart';
import 'package:flutter/material.dart';

class BillersOrProductsDropDown extends StatelessWidget {
  final String label;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  final Widget text;
  final Function iconPress;
  final String hintText, valueText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final List options;
  final String disabledHint;
  final bool validate;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String bankName;

  BillersOrProductsDropDown({
    this.label,
    this.press,
    this.initialValue,
    this.isNumberType = true,
    this.text,
    this.iconPress,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.options,
    this.valueText,
    this.disabledHint = 'disabled',
    this.validate,
    this.validator,
    this.bankName,
  });

  // dynamic name;
  dynamic amount;
  dynamic cableAmount;
  String value;

  @override
  Widget build(BuildContext context) {
    // String name =
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      // height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      // margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

      child: DropdownButtonFormField(
        //  isDense: false,

        // itemHeight: 50,
        onChanged: onChanged,
        //  autovalidate: validate,

        // disabledHint: Text(disabledHint),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            15,
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.red,
          //     width: 1.0,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.purple,
              width: 1.5,
            ),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        items: options == null
            ? null
            : options.map((option) {
                if (option['PRODUCT_AMOUNT'] != null) {
                  dynamic charge =
                      double.parse(option['PRODUCT_AMOUNT']) * 0.07;
                  amount = double.parse(option['PRODUCT_AMOUNT']) + charge;
                }

                if (option['PACKAGE_AMOUNT'] != null) {
                  dynamic charge =
                      double.parse(option['PACKAGE_AMOUNT']) * 0.07;
                  cableAmount = double.parse(option['PACKAGE_AMOUNT']) + charge;
                }

                if (option['network'] != null) {
                  value = option['network'].toString();
                } else if (option['PRODUCT_NAME'] != null) {
                  value = option['PRODUCT_NAME'].toString();
                } else if (option['PACKAGE_NAME'] != null) {
                  value = option['PACKAGE_NAME'].toString();
                }

                return DropdownMenuItem(
                  child: Container(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        option['network'] != null
                            ? Text(option['network'].toString())
                            : Container(),
                        option['PRODUCT_NAME'] != null
                            ? Text(
                                '${option['PRODUCT_NAME']} (\₦${formatPrice(amount.toStringAsFixed(0))})')
                            : Container(),
                        option['PACKAGE_NAME'] != null
                            ? Text(
                                '${option['PACKAGE_NAME']} (\₦${formatPrice(cableAmount.toStringAsFixed(0))})')
                            : Container(),
                      ],
                    ),

                    // Text(option['name'].toString())
                  ),
                  value: value,

                  // option['PRODUCT_NAME'] == null
                  //     ? option['network'].toString()
                  //     : option['PRODUCT_NAME'].toString(),
                );
              }).toList(),
        validator: validator,
        value: valueText,
      ),
    );
  }
}
