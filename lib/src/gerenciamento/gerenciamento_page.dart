import 'package:bonde_do_ru/src/alimento/alimento_bloc.dart';
import 'package:bonde_do_ru/src/alimento/alimento_repositorio.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_bloc.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_page.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_repositorio.dart';
import 'package:bonde_do_ru/src/models/alimento_model.dart';
import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:bonde_do_ru/src/widgets/get_day.dart';
import 'package:bonde_do_ru/src/widgets/get_month.dart';
import 'package:bonde_do_ru/src/widgets/input-field.dart';
import 'package:bonde_do_ru/src/widgets/input_field_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class GerenciamentoPage extends StatefulWidget {
  final Function onTap;
  const GerenciamentoPage({Key key, this.onTap}) : super(key: key);

  @override
  _GerenciamentoPageState createState() => _GerenciamentoPageState();
}

class _GerenciamentoPageState extends State<GerenciamentoPage> {
  final _blocCard = CardapioBloc();
  final _blocAli = AlimentoBloc();
  final _blocCardRepository = CardapioRepositorio();
  final _blocAliRepository = AlimentoRepositorio();
  var selDate = DateTime.now().day;
  var selDay;
  DateTime _date = DateTime.now();
  DateTime _currentData = DateTime.now();
  List<int> aux;

  TextEditingController _textController;

  @override
  void initState() {
    setState(() {
      selDay = getDay(DateTime.now());
      selDate = DateTime.now().day;
      _currentData = DateTime.now();
      _date = DateTime.now();
    });
    super.initState();
  }

  @override
  void dispose() {
    // _refeicaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: gerenciamentoScreen(),
    );
  }

  gerenciamentoScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          cadastrarAlimentos(),
          SizedBox(height: 25),
          cadastrarCategorias(),
          // inserirCardapio(),
        ],
      ),
    );
  }

  cadastrarAlimentos() {
    // Firestore fire = Firestore.instance

    return Card(
      elevation: 7,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Alimentos",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          content: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: <Widget>[
                                InputFieldDialog(
                                  hint: "nome",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  onChanged: _blocAli.setNome,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "açucar",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setAcucar,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "colesterol",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setColesterol,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "calorias",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setCalorias,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "gordura",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setGorduraSaturada,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "sódio",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setSodio,
                                  stream: null,
                                ),
                                SizedBox(height: 15),
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _blocAli.setSearchKey(_blocAli.nome
                                          .substring(0, 1)
                                          .toUpperCase());
                                    });

                                    if (_blocAli.insertOrUpdate())
                                      setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Inserir Alimento".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
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
          ),
          // OutlineButton(
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return CupertinoAlertDialog(
          //           content: Material(
          //             color: Colors.transparent,
          //             child: Column(
          //               children: <Widget>[
          //                 InputFieldDialog(
          //                   hint: "nome",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.text,
          //                   obscure: false,
          //                   onChanged: _blocAli.setNome,
          //                   stream: null,
          //                 ),
          //                 InputFieldDialog(
          //                   hint: "açucar",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.number,
          //                   obscure: false,
          //                   onChanged: _blocAli.setAcucar,
          //                   stream: null,
          //                 ),
          //                 InputFieldDialog(
          //                   hint: "colesterol",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.number,
          //                   obscure: false,
          //                   onChanged: _blocAli.setColesterol,
          //                   stream: null,
          //                 ),
          //                 InputFieldDialog(
          //                   hint: "calorias",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.number,
          //                   obscure: false,
          //                   onChanged: _blocAli.setCalorias,
          //                   stream: null,
          //                 ),
          //                 InputFieldDialog(
          //                   hint: "gordura",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.number,
          //                   obscure: false,
          //                   onChanged: _blocAli.setGorduraSaturada,
          //                   stream: null,
          //                 ),
          //                 InputFieldDialog(
          //                   hint: "sódio",
          //                   controller: _textController,
          //                   icon: Icons.fastfood,
          //                   inputType: TextInputType.number,
          //                   obscure: false,
          //                   onChanged: _blocAli.setSodio,
          //                   stream: null,
          //                 ),
          //                 SizedBox(height: 15),
          //                 FlatButton(
          //                   onPressed: () {
          //                     setState(() {
          //                       _blocAli.setSearchKey(_blocAli.nome
          //                           .substring(0, 1)
          //                           .toUpperCase());
          //                     });

          //                     if (_blocAli.insertOrUpdate()) setState(() {});
          //                     Navigator.of(context).pop();
          //                   },
          //                   color: Colors.amber,
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                   child: Text(
          //                     "Inserir Alimento".toUpperCase(),
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          //   color: Colors.amber,
          //   borderSide: BorderSide(
          //     color: Colors.amber,
          //     // width: 5,
          //   ),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Text(
          //     "Cadastrar Alimento".toUpperCase(),
          //     style: TextStyle(
          //       fontSize: 15,
          //     ),
          //   ),
          // ),
          Container(
            height: 250,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                // height: 500,
                // width: double.infinity,
                child: StreamBuilder<List<Alimento>>(
                  stream: _blocAliRepository.alimentos,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        // height: 60,
                        // width: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 190),
                          child: LinearProgressIndicator(),
                        ),
                      );
                    else
                      return Container(
                        child: Column(
                          // scrollDirection: Axis.horizontal,

                          children: snapshot.data.map((alimento) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  // height: double.infinity,
                                  // width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:
                                          Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ),
                                ),
                                key: Key(alimento.documentId()),
                                onDismissed: (direction) {
                                  _blocAliRepository
                                      .delete(alimento.documentId());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber,
                                  ),
                                  child: ListTile(
                                    title: Text(alimento.nome),
                                    trailing: Icon(Icons.info_outline),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CupertinoAlertDialog(
                                            content: Material(
                                              color: Colors.transparent,
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    alimento.nome.toUpperCase(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 5,
                                                    ),
                                                  ),
                                                  Divider(color: Colors.black),
                                                  Text(
                                                    "AÇUCAR",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    alimento.acucar,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Divider(color: Colors.black),
                                                  Text(
                                                    "CALORIAS",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    alimento.calorias,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Divider(color: Colors.black),
                                                  Text(
                                                    "COLESTEROL",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    alimento.colesterol,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Divider(color: Colors.black),
                                                  Text(
                                                    "GORDURA SATURADA",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    alimento.gorduraSaturada,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Divider(color: Colors.black),
                                                  Text(
                                                    "SÓDIO",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    alimento.sodio,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  Divider(color: Colors.black),
                                                  SizedBox(height: 25),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  cadastrarCategorias() {
    return Card(
      elevation: 7,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categorias",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          content: Material(
                            color: Colors.transparent,
                            child: Column(
                              children: <Widget>[
                                InputFieldDialog(
                                  hint: "nome",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.text,
                                  obscure: false,
                                  onChanged: _blocAli.setNome,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "açucar",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setAcucar,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "colesterol",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setColesterol,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "calorias",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setCalorias,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "gordura",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setGorduraSaturada,
                                  stream: null,
                                ),
                                InputFieldDialog(
                                  hint: "sódio",
                                  controller: _textController,
                                  icon: Icons.fastfood,
                                  inputType: TextInputType.number,
                                  obscure: false,
                                  onChanged: _blocAli.setSodio,
                                  stream: null,
                                ),
                                SizedBox(height: 15),
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _blocAli.setSearchKey(_blocAli.nome
                                          .substring(0, 1)
                                          .toUpperCase());
                                    });

                                    if (_blocAli.insertOrUpdate())
                                      setState(() {});
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Inserir Alimento".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
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
          ),
          
          Container(
            height: 250,
            child: SingleChildScrollView(
              child: SizedBox()
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   // height: 500,
              //   // width: double.infinity,
              //   child: StreamBuilder<List<Alimento>>(
              //     stream: _blocAliRepository.alimentos,
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData)
              //         return Container(
              //           // height: 60,
              //           // width: 60,
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 190),
              //             child: LinearProgressIndicator(),
              //           ),
              //         );
              //       else
              //         return Container(
              //           child: Column(
              //             // scrollDirection: Axis.horizontal,

              //             children: snapshot.data.map((alimento) {
              //               return Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 8),
              //                 child: Dismissible(
              //                   direction: DismissDirection.endToStart,
              //                   background: Container(
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       color: Colors.white,
              //                     ),
              //                     // height: double.infinity,
              //                     // width: double.infinity,
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(right: 10),
              //                       child: Align(
              //                         alignment: Alignment.centerRight,
              //                         child:
              //                             Icon(Icons.delete, color: Colors.red),
              //                       ),
              //                     ),
              //                   ),
              //                   key: Key(alimento.documentId()),
              //                   onDismissed: (direction) {
              //                     _blocAliRepository
              //                         .delete(alimento.documentId());
              //                   },
              //                   child: Container(
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       color: Colors.amber,
              //                     ),
              //                     child: ListTile(
              //                       title: Text(alimento.nome),
              //                       trailing: Icon(Icons.info_outline),
              //                       onTap: () {
              //                         showDialog(
              //                           context: context,
              //                           builder: (BuildContext context) {
              //                             return CupertinoAlertDialog(
              //                               content: Material(
              //                                 color: Colors.transparent,
              //                                 child: Column(
              //                                   children: <Widget>[
              //                                     Text(
              //                                       alimento.nome.toUpperCase(),
              //                                       style: TextStyle(
              //                                         fontSize: 20,
              //                                         fontWeight:
              //                                             FontWeight.bold,
              //                                         letterSpacing: 5,
              //                                       ),
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     Text(
              //                                       "AÇUCAR",
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.left,
              //                                     ),
              //                                     Text(
              //                                       alimento.acucar,
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.right,
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     Text(
              //                                       "CALORIAS",
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.left,
              //                                     ),
              //                                     Text(
              //                                       alimento.calorias,
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.right,
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     Text(
              //                                       "COLESTEROL",
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.left,
              //                                     ),
              //                                     Text(
              //                                       alimento.colesterol,
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.right,
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     Text(
              //                                       "GORDURA SATURADA",
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.left,
              //                                     ),
              //                                     Text(
              //                                       alimento.gorduraSaturada,
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.right,
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     Text(
              //                                       "SÓDIO",
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.left,
              //                                     ),
              //                                     Text(
              //                                       alimento.sodio,
              //                                       style: TextStyle(
              //                                         fontSize: 12,
              //                                         color: Colors.black,
              //                                       ),
              //                                       textAlign: TextAlign.right,
              //                                     ),
              //                                     Divider(color: Colors.black),
              //                                     SizedBox(height: 25),
              //                                   ],
              //                                 ),
              //                               ),
              //                             );
              //                           },
              //                         );
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             }).toList(),
              //           ),
              //         );
              //     },
              //   ),
              // ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  inserirCardapio() {
    return Column(
      children: <Widget>[
        renderDays(),
        Container(
          height: 250,
          width: double.infinity,
          child: StreamBuilder<List<Cardapio>>(
            stream: _blocCardRepository.cardapio,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    if ((snapshot.data[index].dia == getDay(_currentData)) &&
                        (snapshot.data[index].data ==
                            _currentData.day.toString()) &&
                        (snapshot.data[index].mes == getMonth(_currentData)) &&
                        (snapshot.data[index].ano ==
                            _currentData.year.toString())) {
                      if (snapshot.data[index].refeicao.toUpperCase() ==
                          "CAFÉ DA MANHÃ") {
                      } else if (snapshot.data[index].refeicao.toUpperCase() ==
                          "ALMOÇO") {}

                      if (snapshot.data[index].refeicao.toUpperCase() ==
                          "JANTAR") {}

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            height: double.infinity,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                          key: Key(snapshot.data[index].documentId()),
                          onDismissed: (direction) {
                            _blocCardRepository
                                .delete(snapshot.data[index].documentId());
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: snapshot.data[index].refeicao
                                                .toString()
                                                .toUpperCase() ==
                                            "CAFÉ DA MANHÃ"
                                        ? AssetImage("assets/images/cafe.jpg")
                                        : snapshot.data[index].refeicao
                                                    .toString()
                                                    .toUpperCase() ==
                                                "ALMOÇO"
                                            ? AssetImage(
                                                "assets/images/almoco.jpg")
                                            : AssetImage(
                                                "assets/images/jantar.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: ListTile(
                                  // contentPadding: EdgeInsets.all(10),
                                  // title: Text(cardapio.refeicao),
                                  trailing: Icon(Icons.keyboard_arrow_right),
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => SchedulingPage(cardapio)),
                                    // );
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 150,
                                  height: 56,
                                  child: Center(
                                    child: Text(
                                      snapshot.data[index].refeicao,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              );
            },
          ),
        ),

        // Text("Complete os campos para inserir um novo cardápio:"),
        // Container(
        //   color: Colors.grey,
        //   child: InputField(
        //     hint: "refeição",
        //     icon: Icons.fastfood,
        //     inputType: TextInputType.text,
        //     obscure: false,
        //     stream: _blocCard.outRefeicao,
        //     onChanged: _blocCard.setRefeicao,
        //   ),
        // ),
        // TextField(
        //   decoration: InputDecoration(labelText: "Refeição"),
        //   controller: _,
        //   onChanged: _blocCard.setRefeicao,
        // ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CardapioPage(
                  currentDate: _currentData,
                ),
              ),
            );
          },
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Inserir Cardápio".toUpperCase(),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        // RaisedButton(
        //   child: Text("Salvar"),
        //   onPressed: () {
        //     if (_blocCard.insertOrUpdate()) {
        //       _showDialog();
        //     }
        //   },
        // ),
      ],
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Material(
              child: Text("Cardápio inserido com sucesso!"),
            ),
          );
        });
  }

  renderDays() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: <Widget>[
          Container(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                getData(_date, getDay(_date)),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 1)),
                    getDay(_date.add(Duration(days: 1)))),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 2)),
                    getDay(_date.add(Duration(days: 2)))),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 3)),
                    getDay(_date.add(Duration(days: 3)))),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 4)),
                    getDay(_date.add(Duration(days: 4)))),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 5)),
                    getDay(_date.add(Duration(days: 5)))),
                SizedBox(
                  width: 10,
                ),
                getData(_date.add(Duration(days: 6)),
                    getDay(_date.add(Duration(days: 6)))),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getData(DateTime data, String dia) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: switchColor(data),
      ),
      width: 50,
      child: InkWell(
        onTap: () {
          setState(() {
            _blocCard.setDia(getDay(data));
            _blocCard.setData(data.day.toString());
            _blocCard.setMes(getMonth(data));
            _blocCard.setAno(data.year.toString());
            selectedDate(data);
            selDay = dia;
          });
        },
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data.day.toString(),
              style: TextStyle(
                fontSize: 15,
                color: switchContentColor(data),
              ),
            ),
            Divider(
              color: switchContentColor(data),
            ),
            Text(
              dia.substring(0, 3),
              style: TextStyle(
                fontSize: 15,
                color: switchContentColor(data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color switchColor(DateTime data) {
    if (data.day == selDate) {
      return Colors.amber;
    } else {
      return Colors.grey[200];
    }
  }

  Color switchContentColor(DateTime data) {
    if (data.day == selDate) {
      return Colors.black;
    } else {
      return Colors.grey;
    }
  }

  selectedDate(DateTime data) {
    setState(() {
      _currentData = data;
      selDate = data.day;
    });
  }
}
