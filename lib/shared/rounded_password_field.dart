import 'package:Crypto_wallet/shared/text_field_container.dart';
import 'package:Crypto_wallet/shared/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText = "Password",
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: showPassword,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
       
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            // color: Colors.black,
          ),
          focusColor: Colors.grey,
          
          suffixIcon: IconButton(
            icon: Icon( showPassword?Icons.visibility_off:Icons.visibility),
            focusColor: Colors.grey,
            // color: kPrimaryColor,
            onPressed: () {
              setState(() {
                showPassword = !showPassword ? true : false;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
