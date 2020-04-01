import 'package:bonde_do_ru/src/gerenciamento/gerenciamento_module.dart';
import 'package:bonde_do_ru/src/gerenciamento/gerenciamento_page.dart';
import 'package:bonde_do_ru/src/home/home-page.dart';
import 'package:bonde_do_ru/src/home/home_module.dart';
import 'package:bonde_do_ru/src/mensagens/mensagens_widget.dart';
import 'package:bonde_do_ru/src/pages/comentarios-page.dart';
import 'package:bonde_do_ru/src/widgets/drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartWidget extends StatefulWidget {
  @override
  _StartWidgetState createState() => new _StartWidgetState();
}

class _StartWidgetState extends State<StartWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  PageController _pageController = PageController();

  Animation animationTranslate;
  Animation animationSize;
  Animation animationSizeBorder;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    animationTranslate = Tween(begin: 0.0, end: 300.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationTranslate.addListener(() {
      setState(() {});
    });

    animationSize = Tween(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationSize.addListener(() {
      setState(() {});
    });

    animationSizeBorder = Tween(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationSizeBorder.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onTapMenu() {
    if (controller.value == 1) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.menu),
                //   onPressed: _onTapMenu,
                // ),

                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) {
                            return

                                //                     StreamBuilder<List<Schedule>>(
                                //   stream: _bloc.schedule,
                                //   builder: (context, snapshot) {
                                //     if (!snapshot.hasData) return CircularProgressIndicator();

                                //     return Container(
                                //       child: ListView(
                                //         children: snapshot.data.map((schedule) {
                                //           return Dismissible(
                                //             key: Key(schedule.documentId()),
                                //             onDismissed: (direction) {
                                //               _bloc.delete(schedule.documentId());
                                //             },
                                //             child: ListTile(
                                //               title: Text(schedule.name),
                                //               subtitle: Text(_dateFormat.format(schedule.birthDate)),
                                //               trailing: Icon(Icons.keyboard_arrow_right),
                                //               onTap: () {
                                //                 Navigator.push(
                                //                   context,
                                //                   MaterialPageRoute(
                                //                       builder: (context) => SchedulingPage(schedule)),
                                //                 );
                                //               },
                                //             ),
                                //           );
                                //         }).toList(),
                                //       ),
                                //     );
                                //   },
                                // ),

                                Padding(
                              padding:
                                  const EdgeInsets.only(top: 70, right: 15),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CupertinoPopupSurface(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text(
                                            "Notificações:",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black45,
                                          ),
                                          SizedBox(height: 10),
                                          ListTile(
                                            title: Text(
                                              "O restaurante universitário não irá funcionar no dia 01 de janeiro de 2020.",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "23/12/2019",
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    "JC",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ],
        // leading: FlatButton(
        //   // padding: EdgeInsets.only(left: 0),
        //   splashColor: Colors.transparent,
        //   highlightColor: Colors.transparent,

        //   onPressed: widget.onTap,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //   child: Icon(Icons.menu),
        // ),
        // leading: FlatButton.icon(
        //   icon: Icon(FontAwesomeIcons.hamburger),
        //   onPressed: widget.onTap,
        //   label: SizedBox(),
        // ),

        // GestureDetector(
        //   onTap: widget.onTap,
        //   child: Icon(FontAwesomeIcons.hamburger),
        // ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),

        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Início'),
            activeColor: Colors.amber[700],
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Comentários'),
            activeColor: Colors.amber[700],
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.star),
            title: Text('Avaliações'),
            activeColor: Colors.amber[700],
            inactiveColor: Colors.black54,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Gerenciamento', style: TextStyle(fontSize: 12.5),),
            activeColor: Colors.amber[700],
            inactiveColor: Colors.black54,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // DrawerWidget(
          //   pageControllerDrawer: _pageController,
          //   onTap: _onTapMenu,
          // ), //widget do drawer
          Transform.scale(
            scale: animationSize.value,
            child: Container(
              transform: Matrix4.identity()
                ..translate(animationTranslate.value, 0.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(animationSizeBorder.value),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    HomeModule(_onTapMenu, _pageController),
                    ComentariosPage(onTap: _onTapMenu),
                    Scaffold(
                      backgroundColor: Colors.white,
                      body: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Ranking semanal",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(height: 15),
                                      Divider(color: Colors.black),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                            SizedBox(height: 10),
                                            Text("1950 avaliações")
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.black),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
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
                                                  "Feijão",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Text("1120 avaliações")
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.black),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(Icons.star),
                                                    Icon(Icons.star),
                                                    Icon(Icons.star),
                                                    Icon(Icons.star_border),
                                                    Icon(Icons.star_border),
                                                  ],
                                                ),
                                                Text(
                                                  "Arroz",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Text("950 avaliações")
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Card(
                                elevation: 7,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 400,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Ranking geral",
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(height: 15),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      "Feijão",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1120 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star),
                                                        Icon(Icons.star_border),
                                                        Icon(Icons.star_border),
                                                      ],
                                                    ),
                                                    Text(
                                                      "Arroz",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          Divider(color: Colors.black),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Text("1950 avaliações")
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GerenciamentoModule(_onTapMenu),
                    // SearchPage(),
                  ],
                ),
              ),
            ),
          ), //tela inicial
        ],
      ),
    );
  }
}
