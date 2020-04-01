import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/alimento/alimento_bloc.dart';
import 'package:bonde_do_ru/src/alimento/alimento_repositorio.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_bloc.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_repositorio.dart';
import 'package:bonde_do_ru/src/gerenciamento/gerenciamento_bloc.dart';
import 'package:bonde_do_ru/src/home/home_bloc.dart';
import 'package:bonde_do_ru/src/start/start_bloc.dart';
import 'package:bonde_do_ru/src/start/start_widget.dart';
import 'package:flutter/material.dart';

class StartModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => StartBloc()),
        Bloc((i) => GerenciamentoBloc()),
        Bloc((i) => CardapioBloc()),
        Bloc((i) => HomeBloc()),
        Bloc((i) => AlimentoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        // Dependency((i) => CardapioRepositorio()),
        // Dependency((i) => AlimentoRepositorio()),
      ];

  @override
  Widget get view => StartWidget();

  static Inject get to => Inject<StartModule>.of();
}
