
import 'package:Crypto_wallet/widgets/constants.dart';
import 'package:flutter/material.dart';

import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String initialValue;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
    this.initialValue,this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        
        initialValue:  initialValue ,
        
        validator: validator ,
        onChanged: onChanged,
        keyboardType: keyboardType,
        
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            // color: Colors.blue,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        
      ),
      
    );
  }
}
