import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutLinedBox extends StatelessWidget {
  final String label;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  final Widget text;
  final Function iconPress;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool enable;
  final bool readOnly;
  final bool validate;
  final String hintText;
  OutLinedBox(
      {this.label,
      this.press,
      this.initialValue,
      this.isNumberType = true,
      this.text,
      this.iconPress,
      this.controller,
      this.validator,
      this.enable,
      this.readOnly,
      this.validate,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: TextFormField(
        //  autovalidateMode: ,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          suffixIcon: text,
          labelText: label,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
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
          focusColor: Colors.purple,
        ),
        keyboardType: isNumberType
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        inputFormatters: isNumberType
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : [],
        // validator: (value) {
        //   if (value.isEmpty) {
        //     return '$label is required';
        //   }
        //   return null;
        // },
        validator: validator,
        autovalidate: validate,
        onChanged: press,
        enabled: enable,
        initialValue: initialValue,
      ),
    );
  }
}
