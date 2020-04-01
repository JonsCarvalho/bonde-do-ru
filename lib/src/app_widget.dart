import 'package:bonde_do_ru/src/login/login-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login/login_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bonde do RU',
      theme: ThemeData(
        fontFamily: "ProductSans",
        primarySwatch: Colors.amber,
      ),
      home: LoginModule(),
    );
  }
}
