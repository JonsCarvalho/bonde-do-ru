import 'package:bonde_do_ru/src/login/login-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerWidget extends StatefulWidget {
  final PageController pageControllerDrawer;
  final Function onTap;
  const DrawerWidget({Key key, this.pageControllerDrawer, this.onTap})
      : super(key: key);

  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  //identifica qual item foi selecionado
  int itemSelect = 0;

  selectTile(item) {
    setState(() {
      itemSelect = item;
      return itemSelect;
    });
  }

  //cria o avatar com nome, email e imagem
  Widget _avatar() {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
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
                        "JC",
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
          ),
          Container(
            height: 12.0,
          ),
          Text(
            "Jônatas M. Carvalho",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Text(
            "jonatas_carvalhow@live.com",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

//Cria uma listview com os itens do menu
  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        _avatar(),
        _tiles("INÍCIO", Icons.home, 0, () {
          selectTile(0);
          widget.pageControllerDrawer.jumpToPage(0);
          widget.onTap();
        }),
        _tiles("COMENTÁRIOS", Icons.comment, 1, () {
          selectTile(1);
          widget.pageControllerDrawer.jumpToPage(1);
          widget.onTap();
        }),
        _tiles("ALIMENTOS", Icons.fastfood, 2, () {
          selectTile(2);
          widget.pageControllerDrawer.jumpToPage(2);
          widget.onTap();
        }),
        SizedBox(height: 15),
        Divider(),
        SizedBox(height: 15),
        _tiles("SAIR", Icons.arrow_back, 3, () {
          selectTile(3);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }),
      ],
    );
  }

//cria cada item do menu
  Widget _tiles(
    String text,
    IconData icon,
    int item,
    Function onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: item == itemSelect ? Colors.black : Colors.black45,
      ),
      onTap: onTap,
      title: Text(
        text,
        style: TextStyle(
          color: item == itemSelect ? Colors.black : Colors.black45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.amber,
        child: _listMenu(),
      ),
    );
  }
}
