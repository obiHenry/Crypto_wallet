import 'package:flutter/material.dart';

import 'constants.dart';

class DropDownInputField extends StatelessWidget {
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

  DropDownInputField({
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
    this.bankName ,
  });

  // dynamic name;

  @override
  Widget build(BuildContext context) {
    // String name =
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      // height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      // margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),

      child: DropdownButtonFormField(
        onChanged: onChanged,
        //  autovalidate: validate,
        
        disabledHint: Text(disabledHint),
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
        items: options.map((option) {
          // name = option['name'];
          return DropdownMenuItem(
            child:
                Container(width: 230, child: Text(option['name'].toString())
                
                ),
            value: option['name'].toString(),
          );
        }).toList(),
        validator: validator,
        value: valueText,
      ),
    );
  }
}
