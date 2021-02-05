import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:Crypto_wallet/shared/constants.dart';
import 'package:flutter/material.dart';

class BillersOrProductsDropDown extends StatefulWidget {
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

  @override
  _BillersOrProductsDropDownState createState() => _BillersOrProductsDropDownState();
}

class _BillersOrProductsDropDownState extends State<BillersOrProductsDropDown> {
  dynamic amount;

  dynamic cableAmount, minAmount, maxAmount;

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
        isDense: false,

        // itemHeight: 50,
        onChanged: widget.onChanged,
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
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        items: widget.options == null
            ? null
            : widget.options.map((option) {
                if (option['network_id'] != null) {
                  dynamic charge =
                      double.parse(option['price']) * 0.06;
                  amount = double.parse(option['price']) + charge;
                }

                if (option['package'] != null) {
                  cableAmount = double.parse(option['price']);
                }

                if (option['MINIMUN_AMOUNT'] != null) {
                  minAmount = double.parse(option['MINIMUN_AMOUNT']);
                  maxAmount = double.parse(option['MAXIMUM_AMOUNT']);
                }

                if (option['network'] != null) {
                  value = option['network'].toString();
                } else if (option['network_id'] != null) {
                  value = option['name'].toString();
                } else if (option['title'] != null) {
                  value = option['title'].toString();
                } else if (option['PRODUCT_TYPE'] != null) {
                  value = option['PRODUCT_TYPE'].toString();
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
                        option['network_id'] != null
                            ? Text(
                                '${option['name']} (\₦${formatPrice(amount.toStringAsFixed(0))})')
                            : Container(),
                        option['title'] != null
                            ? Text(
                                '${option['title']} (\₦${formatPrice(option['price'])})')
                            : Container(),
                        option['PRODUCT_TYPE'] != null
                            ? Text(
                                '${option['PRODUCT_TYPE']} (min \₦${formatPrice(minAmount.toStringAsFixed(0))} - max \₦${formatPrice(maxAmount.toStringAsFixed(0))})')
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
        validator: widget.validator,
        value: widget.valueText,
      ),
    );
  }
}
