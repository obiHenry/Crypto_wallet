import 'package:flutter/material.dart';
import 'package:Crypto_wallet/shared/text_field_container.dart';

class RoundedDropDown extends StatelessWidget {
  final String label;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  final Widget text;
  final Function iconPress;
  final String hintText, valueText,valueText1;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final List options;
  final String disabledHint;
  final bool validate;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  // final IconData icon;
  // final String bankName;

  RoundedDropDown({
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
    this.valueText1,
      
    // this.bankName,
  });

  // dynamic name;

  @override
  Widget build(BuildContext context) {
    // String name =
    return TextFieldContainer(
      child: DropdownButtonFormField(
        onChanged: onChanged,
        //  autovalidate: validate,

        disabledHint: Text(disabledHint),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(
          //   15,
          // ),
          icon: Icon(
            icon,
            // color: Colors.blue,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        items: options.map((option) {
          // name = option['name'];
          return DropdownMenuItem(
            child:
                Container(width: 183, child: Text(option['name'].toString())),
            value: option['name'].toString(),
          );
        }).toList(),
        validator: validator,
        value: valueText,
      ),
    );
  }
}
