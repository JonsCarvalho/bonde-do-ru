import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:bonde_do_ru/src/widgets/get_day.dart';
import 'package:bonde_do_ru/src/widgets/get_month.dart';
import 'package:bonde_do_ru/src/widgets/input-field.dart';
import 'package:bonde_do_ru/src/widgets/input_field_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cardapio_repositorio.dart';

class CardapioPage extends StatefulWidget {
  final DateTime currentDate;
  final String refeicao;
  CardapioPage({Key key, this.currentDate, this.refeicao}) : super(key: key);

  @override
  _CardapioPageState createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
  // var _radioValue = "Café da Manhã";
  final _blocCard = CardapioBloc();
  final _blocCardRepository = CardapioRepositorio();

  String nomeTemp = "";

  TextEditingController _textController;

  double searchContainerTam = 0.0;

  @override
  void initState() {
    if (widget.refeicao == "Café da Manhã") {
      _blocCard.setInicio("07:00");
    } else if (widget.refeicao == "Almoço") {
      _blocCard.setInicio("11:00");
    } else if (widget.refeicao == "Jantar") {
      _blocCard.setInicio("17:00");
    }
    // _blocCard.setInicio("07:00");
    // _blocCard.setRefeicao(_radioValue);
    _blocCard.setRefeicao(widget.refeicao);
    _blocCard.setDia(getDay(widget.currentDate));
    _blocCard.setData(widget.currentDate.day.toString());
    _blocCard.setMes(getMonth(widget.currentDate));
    _blocCard.setAno(widget.currentDate.year.toString());
    super.initState();
  }

  @override
  void dispose() {
    // _textController.dispose();
    super.dispose();
  }

  setTamSearch(value) {
    setState(() {
      searchContainerTam = value;
    });
  }

  // radioButtonRefeicao(refeicao) {
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     color: Colors.white,
  //     elevation: 5,
  //     child: InkWell(
  //       onTap: () {
  //         setState(() {
  //           _radioValue = refeicao;

  //           if (refeicao == "Café da Manhã") {
  //             _blocCard.setInicio("07:00");
  //           } else if (refeicao == "Almoço") {
  //             _blocCard.setInicio("11:00");
  //           } else if (refeicao == "Jantar") {
  //             _blocCard.setInicio("17:00");
  //           }

  //           _blocCard.setRefeicao(_radioValue);
  //         });
  //       },
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 8),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: _radioValue == refeicao ? Colors.amber : Colors.transparent,
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: <Widget>[
  //             new Text(
  //               refeicao,
  //               style: new TextStyle(fontSize: 16.0),
  //             ),
  //             new Radio<String>(
  //               activeColor: Colors.black,
  //               value: refeicao,
  //               groupValue: _radioValue,
  //               onChanged: (t) {
  //                 setState(() {
  //                   _radioValue = refeicao;
  //                   _blocCard.setRefeicao(_radioValue);
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void initiateSearch(String val) {
    setState(() {
      nomeTemp = val.toLowerCase().trim();
    });
  }

  columnAlimento(categoria, blocCategoria, Function change) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  categoria,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    // setTamSearch(340.0);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          content: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: <Widget>[
                                // InputFieldDialog(
                                //   hint: categoria,
                                //   icon: Icons.fastfood,
                                //   inputType: TextInputType.text,
                                //   obscure: false,
                                //   onChanged: change,
                                //   controller: _textController,
                                // ),
                                TextField(
                                  onChanged: (val) => initiateSearch(val),
                                  decoration: InputDecoration(
                                      // prefixIcon: IconButton(
                                      //   color: Colors.black,
                                      //   icon: Icon(Icons.arrow_back),
                                      //   iconSize: 20.0,
                                      //   onPressed: () {
                                      //     Navigator.of(context).pop();
                                      //   },
                                      // ),
                                      contentPadding:
                                          EdgeInsets.only(left: 25.0),
                                      hintText: 'Buscar alimento',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0))),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  height: 200,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: nomeTemp != "" && nomeTemp != null
                                        ? Firestore.instance
                                            .collection('alimentos')
                                            .where('searchKey',
                                                isEqualTo: nomeTemp
                                                    .substring(0, 1)
                                                    .toUpperCase())
                                            .snapshots()
                                        : Firestore.instance
                                            .collection('alimentos')
                                            .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError)
                                        return new Text(
                                            'Error: ${snapshot.error}');
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          return new Text('Loading...');
                                        default:
                                          return new ListView(
                                            children: snapshot.data.documents
                                                .map((DocumentSnapshot
                                                    document) {
                                              return new ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    change(document["nome"]);
                                                  });

                                                  Navigator.of(context).pop();
                                                },
                                                title:
                                                    new Text(document["nome"]),
                                              );
                                            }).toList(),
                                          );
                                      }
                                    },
                                  ),
                                ),
                                // FlatButton(
                                //   onPressed: () {
                                //     setState(() {});
                                //     Navigator.of(context).pop();
                                //   },
                                //   color: Colors.amber,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(10),
                                //   ),
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: Text(
                                //       "Ok".toUpperCase(),
                                //       style: TextStyle(
                                //         fontSize: 15,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Container(
              height: searchContainerTam,
              // child: Column(
              //   children: <Widget>[
              //     // InputFieldDialog(
              //     //   hint: categoria,
              //     //   icon: Icons.fastfood,
              //     //   inputType: TextInputType.text,
              //     //   obscure: false,
              //     //   onChanged: change,
              //     //   controller: _textController,
              //     // ),
              //     TextField(
              //       onChanged: (val) => initiateSearch(val),
              //       decoration: InputDecoration(
              //           // prefixIcon: IconButton(
              //           //   color: Colors.black,
              //           //   icon: Icon(Icons.arrow_back),
              //           //   iconSize: 20.0,
              //           //   onPressed: () {
              //           //     Navigator.of(context).pop();
              //           //   },
              //           // ),
              //           contentPadding: EdgeInsets.only(left: 25.0),
              //           hintText: 'Buscar alimento',
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(4.0))),
              //     ),
              //     SizedBox(height: 15),
              //     Container(
              //       color: Colors.red,
              //       height: 200,
              //       child: StreamBuilder<QuerySnapshot>(
              //         stream: nomeTemp != "" && nomeTemp != null
              //             ? Firestore.instance
              //                 .collection('alimentos')
              //                 .where('searchKey',
              //                     isEqualTo:
              //                         nomeTemp.substring(0, 1).toUpperCase())
              //                 .snapshots()
              //             : Firestore.instance
              //                 .collection('alimentos')
              //                 .snapshots(),
              //         builder: (BuildContext context,
              //             AsyncSnapshot<QuerySnapshot> snapshot) {
              //           if (snapshot.hasError)
              //             return new Text('Error: ${snapshot.error}');
              //           switch (snapshot.connectionState) {
              //             case ConnectionState.waiting:
              //               return new Text('Loading...');
              //             default:
              //               return new ListView(
              //                 children: snapshot.data.documents
              //                     .map((DocumentSnapshot document) {
              //                   return new ListTile(
              //                     title: new Text(document["nome"]),
              //                   );
              //                 }).toList(),
              //               );
              //           }
              //         },
              //       ),
              //     ),
              //     // FlatButton(
              //     //   onPressed: () {
              //     //     setState(() {});
              //     //     Navigator.of(context).pop();
              //     //   },
              //     //   color: Colors.amber,
              //     //   shape: RoundedRectangleBorder(
              //     //     borderRadius: BorderRadius.circular(10),
              //     //   ),
              //     //   child: Padding(
              //     //     padding: const EdgeInsets.all(8.0),
              //     //     child: Text(
              //     //       "Ok".toUpperCase(),
              //     //       style: TextStyle(
              //     //         fontSize: 15,
              //     //       ),
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
            ),
            Container(
              width: double.infinity,
              child: blocCategoria != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                        ),
                        child: ListTile(
                          title: Text(blocCategoria),
                          trailing: Icon(
                            Icons.info_outline,
                            color: Colors.black,
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SchedulingPage(cardapio)),
                            // );
                          },
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Cardápio".toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ),
          actions: <Widget>[
            Builder(
              builder: (context) => FlatButton.icon(
                onPressed: () {
                  if (_blocCard.pratoPrincipal == null ||
                      _blocCard.guarnicao == null ||
                      _blocCard.dieta == null ||
                      _blocCard.saladaCrua == null ||
                      _blocCard.saladaCozida == null ||
                      _blocCard.bebida == null) {
                    final snackBar = SnackBar(
                      content: Text("Preencha todas as categorias!"),
                      action: SnackBarAction(
                        label: "",
                        onPressed: () {
                          // código para desfazer a ação!
                        },
                      ),
                    );
                    // Encontra o Scaffold na árvore de widgets
                    // e o usa para exibir o SnackBar!
                    Scaffold.of(context).showSnackBar(snackBar);
                  } else if (_blocCard.insertOrUpdate()) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(FontAwesomeIcons.save),
                label: Text("Salvar".toUpperCase()),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${getDay(widget.currentDate)}, ${widget.currentDate.day.toString()} de ${getMonth(widget.currentDate)}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                // new Column(
                //   children: <Widget>[
                //     radioButtonRefeicao("Café da Manhã"),
                //     radioButtonRefeicao("Almoço"),
                //     radioButtonRefeicao("Jantar"),
                //   ],
                // ),
                Text(
                  widget.refeicao.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 25,
                    thickness: .5,
                    color: Colors.black,
                  ),
                ),
                columnAlimento(
                  "Prato Principal",
                  _blocCard.pratoPrincipal,
                  _blocCard.setPratoPrincipal,
                ),
                columnAlimento(
                  "Guarnição",
                  _blocCard.guarnicao,
                  _blocCard.setGuarnicao,
                ),
                columnAlimento(
                  "Dieta",
                  _blocCard.dieta,
                  _blocCard.setDieta,
                ),
                columnAlimento(
                  "Salada Crua",
                  _blocCard.saladaCrua,
                  _blocCard.setSaladaCrua,
                ),
                columnAlimento(
                  "Salada Cozida",
                  _blocCard.saladaCozida,
                  _blocCard.setSaladaCozida,
                ),
                columnAlimento(
                  "Bebida",
                  _blocCard.bebida,
                  _blocCard.setBebida,
                ),
              ],
            ),
          ),
        ));
  }
}
