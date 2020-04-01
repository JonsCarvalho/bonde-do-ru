import 'dart:ui';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextInputType inputType;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField(
      {this.icon,
      this.hint,
      this.obscure,
      this.inputType,
      this.stream,
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
            onChanged: onChanged,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "ProductSans",
              color: Colors.white,
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
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
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
