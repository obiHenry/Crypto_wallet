import 'package:Crypto_wallet/services/price_formatter.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class WalletDropDown extends StatelessWidget {
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

  WalletDropDown({
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
  // bool listIsEmpty = true;

  @override
  Widget build(BuildContext context) {
    // if( options.length == null){

    // }

    return Container(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      // height: 200,
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      // padding: EdgeInsets.only(bottom: 10),
      // height: 200,
      // margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

      child: Column(
        children: [
          DropdownButtonFormField(
            isDense: false,

            itemHeight: 70,
            onChanged: onChanged,
            
            //  autovalidate: validate,

            // disabledHint: Text(disabledHint),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(
                15,
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
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

            items:
                //  options.length == null
                //     ? 0
                //     :
                options.map((option) {
              // name = option['name'];
              return DropdownMenuItem(
                child: Container(
                  // width: 230,
                  width: MediaQuery.of(context).size.width * 0.75,
                  // height: 100,
                  // decoration: BoxDecoration(borderS: ),
                  // padding: EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              child: Image.asset(option['logo']),
                            ),

                            SizedBox(
                              width: 20,
                            ),
                            // Text(option['walletName'].toString()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                    child:
                                        Text(option['walletName'].toString())),
                                FittedBox(
                                  child:
                                   option['walletName'] != 'Naira Wallet'?

                                   Text(
                                      '${option['balance'].toString()}${option['symbol'].toString()}')
                                      : 
                                   Text(
                                      '${option['otherCurrency'].toString()}${option['symbol'].toString()}') ,
                                ),
                                FittedBox(
                                  child:  option['walletName'] != 'Naira Wallet'?
                                  
                                   Text(
                                      '₦${formatPrice(option['otherCurrency'].toString())}')
                                      :  Text(
                                      '₦${option['balance'].toString()}'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
                value: option['walletName'].toString(),
              );
            }).toList(),
            validator: validator,
            value: 'Naira Wallet',
          ),
        ],
      ),
    );
  }
}
