import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class OutlinedNumberInputField extends StatelessWidget {
  final String label;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  OutlinedNumberInputField(
      {this.label, this.press, this.initialValue, this.isNumberType = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: isNumberType
          ? TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: isNumberType
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
          : [],
      validator: (value) {
        if (value.isEmpty) {
          return '$label is required';
        }
        return null;
      },
      onChanged: press,
      initialValue: initialValue,
    );
  }
}
