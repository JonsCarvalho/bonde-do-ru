import 'package:bonde_do_ru/src/start/start_module.dart';
import 'package:bonde_do_ru/src/widgets/background.dart';
import 'package:bonde_do_ru/src/widgets/button.dart';
import 'package:bonde_do_ru/src/widgets/input-field.dart';
import 'package:bonde_do_ru/src/widgets/input_field_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_module.dart';

class LoginPage extends StatelessWidget {
  final _pageController = PageController();

  int _currValue = 1;

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      pageSnapping: true,
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              background(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "BONDE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 7,
                              ),
                            ),
                            Text(
                              "DO",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 7,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "RU",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 105,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Matrícula",
                      icon: CupertinoIcons.person_solid,
                      inputType: TextInputType.number,
                      obscure: false,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Senha",
                      icon: CupertinoIcons.padlock_solid,
                      inputType: TextInputType.visiblePassword,
                      obscure: true,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              content: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                        "Será enviada uma senha temporária para o e-mail cadastrado!"),
                                    SizedBox(height: 15),
                                    InputFieldDialog(
                                      hint: "Matrícula",
                                      inputType: TextInputType.number,
                                      icon: CupertinoIcons.person,
                                      obscure: false,
                                      onChanged: null,
                                      stream: null,
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            "Enviar".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            "Cancelar".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(color: Colors.amber),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Button(
                      text: "ENTRAR",
                      onChanged: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => StartModule(),
                          ),
                        );
                      },
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Não tem um cadastro?",
                          style: TextStyle(color: Colors.white54),
                        ),
                        InkWell(
                          onTap: () {
                            _pageController.nextPage(
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 1000),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " Faça aqui",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              background(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Já tem um cadastro?",
                          style: TextStyle(color: Colors.white54),
                        ),
                        InkWell(
                          onTap: () {
                            _pageController.previousPage(
                              curve: Curves.fastOutSlowIn,
                              duration: Duration(milliseconds: 1000),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              " Faça o login aqui",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.amber,
                          focusColor: Colors.green,
                          hoverColor: Colors.red,
                          value: 1,
                          groupValue: _currValue,
                          onChanged: (t) {},
                        ),
                        Text(
                          "Aluno",
                          style: TextStyle(color: Colors.amber),
                        ),
                        SizedBox(width: 15),
                        Radio(
                          activeColor: Colors.grey,
                          focusColor: Colors.green,
                          hoverColor: Colors.red,
                          value: 1,
                          groupValue: _currValue,
                          onChanged: (int i) => _currValue = i,
                        ),
                        Text(
                          "Funcionário",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "E-mail",
                      icon: Icons.alternate_email,
                      inputType: TextInputType.emailAddress,
                      obscure: false,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Matrícula",
                      icon: CupertinoIcons.person_solid,
                      inputType: TextInputType.number,
                      obscure: false,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Nome",
                      icon: Icons.sort_by_alpha,
                      inputType: TextInputType.number,
                      obscure: false,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Senha",
                      icon: CupertinoIcons.padlock_solid,
                      inputType: TextInputType.visiblePassword,
                      obscure: true,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    InputField(
                      hint: "Confirmar Senha",
                      icon: CupertinoIcons.padlock_solid,
                      inputType: TextInputType.visiblePassword,
                      obscure: true,
                      onChanged: null,
                      stream: null,
                    ),
                    SizedBox(height: 15),
                    Button(
                      text: "CADASTRAR",
                      onChanged: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginModule(),
                          ),
                        );
                      },
                      stream: null,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
