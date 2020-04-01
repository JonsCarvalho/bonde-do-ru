import 'package:bonde_do_ru/src/models/mensagens_model.dart';
import 'package:bonde_do_ru/src/widgets/input_field_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mensagens_repositorio.dart';

final _blocRepositorio = MensagensRepositorio();
final _dateFormat = DateFormat("dd/MM/yyyy");
String _textMensagem = "";
// FocusNode myFocusNode;
// BuildContext context;

Widget avatar(iniciais) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Colors.amber[800],
          gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.amber[900],
              // Colors.amber[800],
              // Colors.white,
              // Colors.black,
            ],
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      Container(
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.black, //Color(0xff827daa),
          child: Text(
            iniciais,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget inputMessage() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white60,
            ),
            width: double.infinity,
            child: TextField(
              onChanged: (text) {
                _textMensagem = text;
              },
              textInputAction: TextInputAction.done,
              // focusNode: myFocusNode,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                // fontSize: 18,
              ),
              keyboardType: TextInputType.text,
              cursorColor: Colors.amber,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: EdgeInsets.only(top: 30, left: 20),
                // suffixIcon:
                // IconButton(
                //   icon: Icon(Icons.send),
                //   onPressed: () {
                //     // FocusScope.of(context).requestFocus(myFocusNode);
                //     var mensagens = Mensagens()
                //       ..mensagem = _textMensagem
                //       ..horario = DateTime.now()
                //       ..nomeUsuario = "Jônatas"
                //       ..imageUsuario = "";
                //     if (_textMensagem != "") _blocRepositorio.add(mensagens);

                //     _textMensagem = "";
                //   },
                // ),
                hintText: "Digite um comentário",
                hintStyle: TextStyle(
                    // color: Colors.black,
                    // fontSize: 12,
                    // letterSpacing: 5,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: RaisedButton(
            color: Colors.amber,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(12),
            child: Icon(Icons.send),
            onPressed: () {
              // FocusScope.of(context).requestFocus(myFocusNode);
              var mensagens = Mensagens()
                ..mensagem = _textMensagem
                ..horario = DateTime.now()
                ..nomeUsuario = "Jônatas"
                ..imageUsuario = "";
              if (_textMensagem != "") _blocRepositorio.add(mensagens);

              _textMensagem = "";
            },
          ),
        ),
      ],
    ),
  );
}

Widget chat() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: StreamBuilder<List<Mensagens>>(
      stream: _blocRepositorio.mensagens,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return Container(
          child: Column(
            children: snapshot.data.map((mensagens) {
              return Dismissible(
                key: Key(mensagens.documentId()),
                onDismissed: (direction) {
                  _blocRepositorio.delete(mensagens.documentId());
                },
                child: ListTile(
                  title: Text(mensagens.mensagem),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(mensagens.nomeUsuario),
                      Text(
                          "${mensagens.horario.hour}:${mensagens.horario.minute}"),
                    ],
                  ),
                  trailing: avatar("JC"),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SchedulingPage(mensagens)),
                    // );
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    ),
  );
}
