import 'package:flutter/material.dart';
import '../styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.custController,
    required this.custObscure,
  });

  String label;
  TextEditingController custController;
  bool custObscure;
  Color? custColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: custController,
      obscureText: custObscure,
      obscuringCharacter: '•',
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'SF_Pro',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        letterSpacing: 1.4,
        height: 1.5,
      ),
      cursorColor: const Color(0xFF9B51E0),
      cursorWidth: 1,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF9B51E0),
        )),
        labelText: label,
        labelStyle: secondaryTextStyle,
        floatingLabelStyle: const TextStyle(
          color: Color(0xFF9B51E0),
          fontSize: 16,
        ),
      ),
    );
  }
}
