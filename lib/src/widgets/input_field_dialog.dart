import 'dart:ui';
import 'package:flutter/material.dart';

class InputFieldDialog extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextInputType inputType;
  final Stream<String> stream;
  final TextEditingController controller;
  final Function(String) onChanged;

  InputFieldDialog(
      {this.icon,
      this.hint,
      this.obscure,
      this.inputType,
      this.stream,
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white60,
          ),
          width: double.infinity,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "ProductSans",
              color: Colors.black,
              fontSize: 18,
            ),
            obscureText: obscure,
            keyboardType: inputType,
            cursorColor: Colors.amber,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: snapshot.hasError ? snapshot.error : null,
              contentPadding: EdgeInsets.only(top: 30, left: 20),
              hintText: hint.toUpperCase(),
              prefixIcon: Icon(
                icon,
                color: Colors.black,
              ),
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 10,
                letterSpacing: 5,
              ),
            ),
          ),
        );
      },
    );
  }
}
