import 'dart:ui';
import 'package:bonde_do_ru/src/start/start_module.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Stream<String> stream;
  final Function onChanged;

  Button({this.text, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          height: 50,
          child: RaisedButton(
            color: Colors.amber,
            elevation: 10,
            splashColor: Colors.red,
            disabledColor: Colors.amber, //Colors.amber.withOpacity(.7),
            disabledTextColor: Colors.white, //Colors.white54,
            textColor: Colors.black,
            onPressed: onChanged, //snapshot.hasData ? onChanged : null,
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10),
            ),
          ),

          // RaisedButton(
          //   onPressed: (){},
          //   color: Colors.amber,

          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Text(text),
          // ),
        );
      },
    );
  }
}
