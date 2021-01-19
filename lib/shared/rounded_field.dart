import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Crypto_wallet/shared/text_field_container.dart';
// import 'constants.dart';

class RoundedField extends StatelessWidget {
  final String label;
   final String hintText;
  final ValueChanged<String> press;
  final String initialValue;
  final bool isNumberType;
  final Widget text;
  final Function iconPress;
  final bool enabled;
  final TextEditingController controller;
  final IconData icon;
  RoundedField(
      {this.label,
      this.press,
      this.initialValue,
      this.isNumberType = true,
      this.text, this.iconPress, this.controller,
      this.enabled,this.hintText,
      this.icon = Icons.person,});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: press,
        enabled: enabled,
        initialValue: initialValue,
        controller: controller ,
      
        decoration: InputDecoration(
          hintText: hintText,
           border: InputBorder.none,
          
          suffixIcon: text,
         icon: Icon(
            icon,
            // color: Colors.blue,
          ),
          // labelText: label,
        ),
        keyboardType: isNumberType
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        inputFormatters: isNumberType
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : [],
        
      ),
    );
  }
}