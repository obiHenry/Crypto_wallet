
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendtextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  final Widget text;
  final Function iconPress;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final bool enable;
  final bool validate;
  final String hintText;
  SendtextField(
      {this.label,
      this.press,
      this.initialValue,
      this.isNumberType = true,
      this.text,
      this.iconPress,
      this.controller,
      this.validator,
      this.enable,
      this.validate, 
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        
        //  autovalidateMode: ,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: text,
          labelText: label,
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
        ),
        keyboardType: isNumberType
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        inputFormatters: isNumberType
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,100}'))]
            : [],
            
        validator: validator,
        autovalidate: validate,
        enabled: enable,
        onChanged: press,
        initialValue: initialValue,

      ),
    );
  }
}
