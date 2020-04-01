import 'package:bonde_do_ru/src/cardapio/cardapio_page.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_repositorio.dart';
import 'package:bonde_do_ru/src/mensagens/mensagens_repositorio.dart';
import 'package:bonde_do_ru/src/mensagens/mensagens_widget.dart';
import 'package:bonde_do_ru/src/models/cardapio_cache.dart';
import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:bonde_do_ru/src/models/mensagens_model.dart';
import 'package:bonde_do_ru/src/widgets/get_day.dart';
import 'package:bonde_do_ru/src/widgets/get_month.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final Function onTap;
  final PageController pageController;
  const HomePage({Key key, this.onTap, this.pageController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selDate = DateTime.now().day;
  var selDay;
  var _selectedIndex = 0;
  DateTime _date = DateTime.now();
  DateTime _currentData = DateTime.now();

  CardapioCache cafe = new CardapioCache();
  CardapioCache almoco = new CardapioCache();
  CardapioCache jantar = new CardapioCache();

  bool auxCafe = false;
  bool auxAlmoco = false;
  bool auxJantar = false;
  double getTam = 150;

  final _blocCardRepository = CardapioRepositorio();
  final _blocRepositorioMessages = MensagensRepositorio();

  Map<String, bool> aux = {
    "Café da Manhã": false,
    "Almoço": false,
    "Jantar": false
  };

  List<Map<String, List<Map<String, double>>>> alimentos = [
    {
      "Feijão": [
        {"calorias": 155},
        {"colesterol": 0.0},
        {"gordura saturada": 0.0},
        {"sódio": 5.4},
        {"açúcar": 0.1},
      ],
    },
    {
      "Arroz": [
        {"calorias": 315},
        {"colesterol": 2.7},
        {"gordura saturada": 1.0},
        {"sódio": 2.6},
        {"açúcar": 1.1},
      ],
    },
    {
      "Frango": [
        {"calorias": 385},
        {"colesterol": 3.1},
        {"gordura saturada": 2.2},
        {"sódio": 3.4},
        {"açúcar": 0.8},
      ],
    },
  ];

  //alimento, suas calorias, colesterol,
  //gordura saturada, sódio e açúcar.
  //Deve constar também os percentuais
  //ideais para a saúde e os percentuais
  //de cada alimento.

  @override
  void initState() {
    super.initState();

    setState(() {
      selDay = getDay(DateTime.now());
      selDate = DateTime.now().day;
      _currentData = DateTime.now();
      _date = DateTime.now();
    });
    getCardapiosFirestore();
  }

  getSalutation() {
    int hour = DateTime.now().hour;
    if ((hour >= 0) && (hour < 5)) {
      return "Boa madrugada";
    } else if ((hour >= 5) && (hour < 12)) {
      return "Bom dia";
    } else if ((hour >= 12) && (hour < 18)) {
      return "Boa tarde";
    } else if (hour >= 18) {
      return "Boa noite";
    }
  }

  _showDialog(CardapioCache cardapio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.amber,
              borderRadius: BorderRadius.circular(0),
              child: Text(
                "Voltar".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
          content: getCardapio(cardapio),
        );
      },
    );
  }

  _showDialogAvaliar(CardapioCache cardapio, dia) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: CupertinoButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(0),
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CupertinoButton(
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(0),
                    padding: EdgeInsets.all(0),
                    child: Text(
                      "CANCELAR",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Avaliação Cardápio".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                Text(
                  "${getDay(dia)}, ${dia.day.toString()} de ${getMonth(dia)}",
                  style: TextStyle(
                    fontSize: 15,

                    // fontWeight: FontWeight.bold,
                    // letterSpacing: 5,
                  ),
                ),
                Text(
                  cardapio.refeicao,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.amber[900],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "PRATO PRINCIPAL",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        cardapio.pratoPrincipal,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "GUARNIÇÃO",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        cardapio.guarnicao,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "DIETA",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                        ],
                      ),
                      Text(
                        cardapio.dieta,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "SALADA CRUA",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        cardapio.saladaCrua,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "SALADA COZIDA",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        cardapio.saladaCozida,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                Text(
                  "BEBIDA",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.star),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      ),
                      Text(
                        cardapio.bebida,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
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
                getData(_date.add(Duration(days: 1)),
                    getDay(_date.add(Duration(days: 1)))),
                getData(_date.add(Duration(days: 2)),
                    getDay(_date.add(Duration(days: 2)))),
                getData(_date.add(Duration(days: 3)),
                    getDay(_date.add(Duration(days: 3)))),
                getData(_date.add(Duration(days: 4)),
                    getDay(_date.add(Duration(days: 4)))),
                getData(_date.add(Duration(days: 5)),
                    getDay(_date.add(Duration(days: 5)))),
                getData(_date.add(Duration(days: 6)),
                    getDay(_date.add(Duration(days: 6)))),
                SizedBox(
                  width: 15,
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
      margin: EdgeInsets.only(left: 15),
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

  getRefeicao(CardapioCache cardapio) {
    return Card(
      margin: EdgeInsets.only(left: 15, bottom: 15),
      color: Colors.amber,
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.amber,
                image: DecorationImage(
                  image: cardapio.refeicao.toString().toUpperCase() ==
                          "CAFÉ DA MANHÃ"
                      ? AssetImage("assets/images/cafe.jpg")
                      : cardapio.refeicao.toString().toUpperCase() == "ALMOÇO"
                          ? AssetImage("assets/images/almoco.jpg")
                          : AssetImage("assets/images/jantar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                height: 70,
                width: 210,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  setHorarios2(cardapio.refeicao),
                  SizedBox(height: 10),
                  Text(
                    cardapio.refeicao.toString().toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
              // color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                return _showDialog(cardapio);
              },
              splashColor: Colors.red.withAlpha(100),
              hoverColor: Colors.blue,
              child: SizedBox(width: 177, height: double.infinity)
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       SizedBox(height: 25),
              //     ],
              //   ),
              // ),
              ),
        ],
      ),
    );
  }

  setHorarios(nome) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Início:".toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              Text(
                nome.toString().toUpperCase() == "CAFÉ DA MANHÃ"
                    ? "07:00"
                    : nome.toString().toUpperCase() == "ALMOÇO"
                        ? "11:00"
                        : "17:00",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Término:".toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  // fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                nome.toString().toUpperCase() == "CAFÉ DA MANHÃ"
                    ? "09:00"
                    : nome.toString().toUpperCase() == "ALMOÇO"
                        ? "14:00"
                        : "19:00",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  setHorarios2(nome) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "Início:".toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              nome.toString().toUpperCase() == "CAFÉ DA MANHÃ"
                  ? "07:00"
                  : nome.toString().toUpperCase() == "ALMOÇO"
                      ? "11:00"
                      : "17:00",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 35),
        Column(
          children: <Widget>[
            Text(
              "Término:".toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Text(
              nome.toString().toUpperCase() == "CAFÉ DA MANHÃ"
                  ? "09:00"
                  : nome.toString().toUpperCase() == "ALMOÇO"
                      ? "14:00"
                      : "19:00",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  getCardapio(CardapioCache cardapio) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              image: DecorationImage(
                image: cardapio.refeicao.toString().toUpperCase() ==
                        "CAFÉ DA MANHÃ"
                    ? AssetImage("assets/images/cafe.jpg")
                    : cardapio.refeicao.toString().toUpperCase() == "ALMOÇO"
                        ? AssetImage("assets/images/almoco.jpg")
                        : AssetImage("assets/images/jantar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: setHorarios(cardapio.refeicao),
          ),
          SizedBox(height: 10),
          Text(
            "Cardápio ".toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.refeicao.toString().toUpperCase(),
            style: TextStyle(
              fontSize: 15,
              color: Colors.amber[900],
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            " ${getDay(_currentData)}, ${_currentData.day.toString()} de ${getMonth(_currentData)}",
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.left,
          ),
          Divider(color: Colors.black),
          Text(
            "PRATO PRINCIPAL",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.pratoPrincipal,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          Text(
            "GUARNIÇÃO",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.guarnicao,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          Text(
            "DIETA",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.dieta,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          Text(
            "SALADA CRUA",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.saladaCrua,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          Text(
            "SALADA COZIDA",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.saladaCozida,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          Text(
            "BEBIDA",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            cardapio.bebida,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
          Divider(color: Colors.black),
          SizedBox(height: 10),
          _currentData.day == _date.day
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Já ",
                      style: TextStyle(color: Colors.black),
                    ),
                    cardapio.refeicao == "Café da Manhã"
                        ? Text(
                            "tomou café?",
                            style: TextStyle(color: Colors.black),
                          )
                        : cardapio.refeicao == "Almoço"
                            ? Text(
                                "almoçou?",
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                "jantou?",
                                style: TextStyle(color: Colors.black),
                              ),
                    InkWell(
                      onTap: () {
                        _showDialogAvaliar(cardapio, _currentData);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          " Avalie aqui",
                          style: TextStyle(color: Colors.amber[900]),
                        ),
                      ),
                    ),
                  ],
                )
              : Text(
                  "Só é possível avaliar o dia atual!",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
        ],
      ),
    );
  }

  getCardapioBanner(CardapioCache cardapio) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 7,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _showDialog(cardapio);
        },
        // splashColor: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: DecorationImage(
                  image: cardapio.refeicao.toString().toUpperCase() ==
                          "CAFÉ DA MANHÃ"
                      ? AssetImage("assets/images/cafe.jpg")
                      : cardapio.refeicao.toString().toUpperCase() == "ALMOÇO"
                          ? AssetImage("assets/images/almoco.jpg")
                          : AssetImage("assets/images/jantar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: setHorarios(cardapio.refeicao),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: <Widget>[
                  Text(
                    "Horário do ".toUpperCase(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  Text(
                    cardapio.refeicao.toString().toUpperCase(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
              child: Text(
                "Venha conferir o cardápio!",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buttonInserirCardapio(refeicao) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: 15, bottom: 15),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CardapioPage(
                currentDate: _currentData,
                refeicao: refeicao,
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
            "Inserir Cardápio\n$refeicao".toUpperCase(),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  getCardapiosFirestore() async {
    var firestore = Firestore.instance;
    QuerySnapshot query =
        await firestore.collection("cardapio").orderBy("inicio").getDocuments();

    if (this.mounted) {
      setState(() {
        auxCafe = false;
        auxAlmoco = false;
        auxJantar = false;
        for (int i = 0; i < query.documents.length; i++) {
          if (getDay(_currentData) == query.documents[i]["dia"]) {
            switch (query.documents[i]["refeicao"]) {
              case "Café da Manhã":
                auxCafe = true;
                cafe.setDocumentId(query.documents[i].documentID);
                cafe.setRefeicao(query.documents[i]["refeicao"]);
                cafe.setInicio(query.documents[i]["inicio"]);
                cafe.setDia(query.documents[i]["dia"]);
                cafe.setData(query.documents[i]["data"]);
                cafe.setMes(query.documents[i]["mes"]);
                cafe.setAno(query.documents[i]["ano"]);
                cafe.setPratoPrincipal(query.documents[i]["pratoPrincipal"]);
                cafe.setGuarnicao(query.documents[i]["guarnicao"]);
                cafe.setDieta(query.documents[i]["dieta"]);
                cafe.setSaladaCrua(query.documents[i]["saladaCrua"]);
                cafe.setSaladaCozida(query.documents[i]["saladaCozida"]);
                cafe.setBebida(query.documents[i]["bebida"]);
                break;
              case "Almoço":
                auxAlmoco = true;
                almoco.setDocumentId(query.documents[i].documentID);
                almoco.setRefeicao(query.documents[i]["refeicao"]);
                almoco.setInicio(query.documents[i]["inicio"]);
                almoco.setDia(query.documents[i]["dia"]);
                almoco.setData(query.documents[i]["data"]);
                almoco.setMes(query.documents[i]["mes"]);
                almoco.setAno(query.documents[i]["ano"]);
                almoco.setPratoPrincipal(query.documents[i]["pratoPrincipal"]);
                almoco.setGuarnicao(query.documents[i]["guarnicao"]);
                almoco.setDieta(query.documents[i]["dieta"]);
                almoco.setSaladaCrua(query.documents[i]["saladaCrua"]);
                almoco.setSaladaCozida(query.documents[i]["saladaCozida"]);
                almoco.setBebida(query.documents[i]["bebida"]);
                break;
              case "Jantar":
                auxJantar = true;
                jantar.setDocumentId(query.documents[i].documentID);
                jantar.setRefeicao(query.documents[i]["refeicao"]);
                jantar.setInicio(query.documents[i]["inicio"]);
                jantar.setDia(query.documents[i]["dia"]);
                jantar.setData(query.documents[i]["data"]);
                jantar.setMes(query.documents[i]["mes"]);
                jantar.setAno(query.documents[i]["ano"]);
                jantar.setPratoPrincipal(query.documents[i]["pratoPrincipal"]);
                jantar.setGuarnicao(query.documents[i]["guarnicao"]);
                jantar.setDieta(query.documents[i]["dieta"]);
                jantar.setSaladaCrua(query.documents[i]["saladaCrua"]);
                jantar.setSaladaCozida(query.documents[i]["saladaCozida"]);
                jantar.setBebida(query.documents[i]["bebida"]);
                break;
              default:
            }
          }
        }
      });
    }
  }

  setTam(double value) {
    setState(() {
      getTam = value;
    });
  }

  renderHorarios() {
    if (_currentData.day != _date.day) {
      getCardapiosFirestore();
      setTam(150);
      return Container(
        height: getTam,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            auxCafe
                ? getRefeicao(cafe)
                : buttonInserirCardapio("Café da Manhã"),
            SizedBox(width: 15),
            auxAlmoco ? getRefeicao(almoco) : buttonInserirCardapio("Almoço"),
            SizedBox(width: 15),
            auxJantar ? getRefeicao(jantar) : buttonInserirCardapio("Jantar"),
            SizedBox(width: 15),
          ],
        ),
      );
    } else if ((int.parse(
            TimeOfDay.now().format(context).toString().substring(0, 2) +
                TimeOfDay.now().format(context).toString().substring(3, 5))) <=
        int.parse("0900")) {
      getCardapiosFirestore();
      auxCafe ? setTam(280) : setTam(150);
      return auxCafe
          ? Container(
              height: getTam,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  getCardapioBanner(cafe),
                  SizedBox(height: 15),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        auxAlmoco
                            ? getRefeicao(almoco)
                            : buttonInserirCardapio("Almoço"),
                        SizedBox(width: 15),
                        auxJantar
                            ? getRefeicao(jantar)
                            : buttonInserirCardapio("Jantar"),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: getTam,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  buttonInserirCardapio("Café da Manhã"),
                  SizedBox(width: 15),
                  auxAlmoco
                      ? getRefeicao(almoco)
                      : buttonInserirCardapio("Almoço"),
                  SizedBox(width: 15),
                  auxJantar
                      ? getRefeicao(jantar)
                      : buttonInserirCardapio("Jantar"),
                  SizedBox(width: 15),
                ],
              ),
            );
    } else if ((int.parse(
            TimeOfDay.now().format(context).toString().substring(0, 2) +
                TimeOfDay.now().format(context).toString().substring(3, 5))) <=
        int.parse("1400")) {
      getCardapiosFirestore();
      auxAlmoco ? setTam(280) : setTam(150);
      return auxAlmoco
          ? Container(
              height: getTam,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  getCardapioBanner(almoco),
                  SizedBox(height: 15),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        auxJantar
                            ? getRefeicao(jantar)
                            : buttonInserirCardapio("Jantar"),
                        SizedBox(width: 15),
                        auxCafe
                            ? getRefeicao(cafe)
                            : buttonInserirCardapio("Café da Manhã"),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: getTam,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  buttonInserirCardapio("Almoço"),
                  SizedBox(width: 15),
                  auxJantar
                      ? getRefeicao(jantar)
                      : buttonInserirCardapio("Jantar"),
                  SizedBox(width: 15),
                  auxCafe
                      ? getRefeicao(cafe)
                      : buttonInserirCardapio("Café da Manhã"),
                  SizedBox(width: 15),
                ],
              ),
            );
    } else if ((int.parse(
            TimeOfDay.now().format(context).toString().substring(0, 2) +
                TimeOfDay.now().format(context).toString().substring(3, 5))) <=
        int.parse("1900")) {
      getCardapiosFirestore();
      auxJantar ? setTam(280) : setTam(150);
      return auxJantar
          ? Container(
              height: getTam,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  getCardapioBanner(jantar),
                  SizedBox(height: 15),
                  Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        auxAlmoco
                            ? getRefeicao(almoco)
                            : buttonInserirCardapio("Almoço"),
                        // SizedBox(width: 15),
                        auxCafe
                            ? getRefeicao(cafe)
                            : buttonInserirCardapio("Café da Manhã"),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: getTam,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  buttonInserirCardapio("Jantar"),
                  SizedBox(width: 15),
                  auxAlmoco
                      ? getRefeicao(almoco)
                      : buttonInserirCardapio("Almoço"),
                  SizedBox(width: 15),
                  auxCafe
                      ? getRefeicao(cafe)
                      : buttonInserirCardapio("Café da Manhã"),
                  SizedBox(width: 15),
                ],
              ),
            );
    } else {
      getCardapiosFirestore();
      setTam(150);
      return Container(
        height: getTam,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            auxCafe
                ? getRefeicao(cafe)
                : buttonInserirCardapio("Café da Manhã"),
            SizedBox(width: 15),
            auxAlmoco ? getRefeicao(almoco) : buttonInserirCardapio("Almoço"),
            SizedBox(width: 15),
            auxJantar ? getRefeicao(jantar) : buttonInserirCardapio("Jantar"),
            SizedBox(width: 15),
          ],
        ),
      );
    }
  }

  Widget homeScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      // padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${getSalutation()}, Jônatas!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                Text(
                  "${getDay(DateTime.now())}, ${DateTime.now().day.toString()} de ${getMonth(DateTime.now())}",
                  style: TextStyle(
                    color: Colors.amber[900],
                    fontSize: 17,
                    // fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(height: 15),

          renderDays(),

          renderHorarios(),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     "Pressione para ver o cardápio".toUpperCase(),
          //     style: TextStyle(
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Card(
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Avaliações recentes",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.black),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star_border),
                            ],
                          ),
                          Text(
                            "Batata doce",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.black),
                    SizedBox(height: 15),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      child: StreamBuilder<List<Mensagens>>(
                        stream: _blocRepositorioMessages.mensagens,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();

                          return ListTile(
                            title: Text(snapshot.data.first.mensagem),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(snapshot.data.first.nomeUsuario),
                                Text(
                                    "${snapshot.data.first.horario.hour}:${snapshot.data.first.horario.minute}"),
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  comp() {
    setState(() {
      if (_currentData == _date)
        return true;
      else
        return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavyBar(
      //   selectedIndex: _selectedIndex,
      //   showElevation: true, // use this to remove appBar's elevation
      //   onItemSelected: (index) => setState(() {
      //     _selectedIndex = index;
      //     widget.pageController.animateToPage(index,
      //         duration: Duration(milliseconds: 300), curve: Curves.ease);
      //   }),
      //   backgroundColor: Colors.amber,
      //   items: [
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.apps),
      //       title: Text('Home'),
      //       activeColor: Colors.red,
      //     ),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.people),
      //         title: Text('Users'),
      //         activeColor: Colors.purpleAccent),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.message),
      //         title: Text('Messages'),
      //         activeColor: Colors.pink),
      //     BottomNavyBarItem(
      //         icon: Icon(Icons.settings),
      //         title: Text('Settings'),
      //         activeColor: Colors.blue),
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: homeScreen(),
    );
  }
}
