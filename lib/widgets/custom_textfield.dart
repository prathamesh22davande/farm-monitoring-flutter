import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {

  final String label;
  final bool isPassword;
  final int textColor;
  final int lablelColor;
  Function changeValue;
  CustomTextField({this.label,this.isPassword,this.textColor,this.lablelColor,this.changeValue});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      onChanged: (value){
        changeValue(value);
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Color(textColor)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(lablelColor)),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(lablelColor), width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Color(lablelColor), width: 2.0),
        ),
      ),
    );
  }
}

