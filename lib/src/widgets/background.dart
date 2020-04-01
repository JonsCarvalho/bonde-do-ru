import 'dart:ui';
import 'package:flutter/material.dart';

Widget background() {
  return Container(
    decoration: new BoxDecoration(
      color: Colors.red,
      image: new DecorationImage(
        image: new AssetImage("assets/images/ru.jpg"),
        fit: BoxFit.cover,
        // colorFilter: new ColorFilter.mode(
        //   Colors.white,
        //   // BlendMode.,
        // ),
      ),
    ),
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.5),
          ),
          width: double.infinity,
        ),
      ),
    ),
  );
}
