import 'package:bonde_do_ru/src/mensagens/mensagens_widget.dart';
import 'package:bonde_do_ru/src/widgets/input_field_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComentariosPage extends StatefulWidget {
  final Function onTap;
  const ComentariosPage({Key key, this.onTap}) : super(key: key);

  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  Widget _avatar(iniciais) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 15),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.amber[800],
            gradient: LinearGradient(
              colors: [
                Colors.amber[800],
                Colors.white,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.red,
            highlightColor: Colors.black,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.black, //Color(0xff827daa),
                child: Text(
                  iniciais,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   // title: Text(
      //   //   "BONDE DO R.U.",
      //   //   style: TextStyle(fontFamily: "ProductSans"),
      //   // ),
      //   leading: GestureDetector(
      //     onTap: widget.onTap,
      //     child: Icon(FontAwesomeIcons.hamburger),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            inputMessage(),
            Container(
              height: MediaQuery.of(context).size.height - 190,
              child: SingleChildScrollView(
                child: chat(),
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   child: Column(
      //     children: <Widget>[
      //       Expanded(
      //         flex: 8,
      //         child: SingleChildScrollView(
      //           child: Column(
      //             children: <Widget>[
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   children: <Widget>[
      //                     Card(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(60)),
      //                       elevation: 7,
      //                       child: Row(
      //                         children: <Widget>[
      //                           _avatar("JC"),
      //                           Text(
      //                             "O café hoje estava muito bom!",
      //                             style: TextStyle(
      //                               fontSize: 17,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(right: 15),
      //                       child: Align(
      //                         alignment: Alignment.centerRight,
      //                         child: Text(
      //                           "17/12/2019, Terça",
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   children: <Widget>[
      //                     Card(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(60)),
      //                       elevation: 7,
      //                       child: Row(
      //                         children: <Widget>[
      //                           _avatar("GB"),
      //                           Text(
      //                             "O almoço estava uma delícia!",
      //                             style: TextStyle(
      //                               fontSize: 17,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(right: 15),
      //                       child: Align(
      //                         alignment: Alignment.centerRight,
      //                         child: Text(
      //                           "17/12/2019, Terça",
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   children: <Widget>[
      //                     Card(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(60)),
      //                       elevation: 7,
      //                       child: Row(
      //                         children: <Widget>[
      //                           _avatar("VJ"),
      //                           Text(
      //                             "O suco estava muito aguado!",
      //                             style: TextStyle(
      //                               fontSize: 17,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(right: 15),
      //                       child: Align(
      //                         alignment: Alignment.centerRight,
      //                         child: Text(
      //                           "17/12/2019, Terça",
      //                           style: TextStyle(
      //                             fontSize: 12,
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 3,
      //         child: Container(
      //           child: Center(
      //             child: Padding(
      //               padding: const EdgeInsets.all(15),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Expanded(
      //                     flex: 6,
      //                     child: InputFieldDialog(
      //                       hint: "Digite uma mensagem!",
      //                       controller: null,
      //                       icon: null,
      //                       inputType: TextInputType.text,
      //                       obscure: false,
      //                       onChanged: null,
      //                       stream: null,
      //                     ),
      //                   ),
      //                   Expanded(
      //                     flex: 2,
      //                     child: FloatingActionButton(
      //                       // shape: RoundedRectangleBorder(
      //                       //   borderRadius: BorderRadius.circular(100)
      //                       // ),
      //                       // color: Colors.amber,
      //                       onPressed: () {},
      //                       child: Icon(Icons.send),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
