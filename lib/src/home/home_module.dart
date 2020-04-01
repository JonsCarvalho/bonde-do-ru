import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_bloc.dart';
import 'package:flutter/material.dart';
import 'home-page.dart';
import 'home_bloc.dart';

class HomeModule extends ModuleWidget {
  final Function onTap;
  final PageController pageController;
  HomeModule(this.onTap, this.pageController);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc()),
        Bloc((i) => CardapioBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage(onTap: onTap, pageController: pageController);

  static Inject get to => Inject<HomeModule>.of();
}
