import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/mensagens/mensagens_repositorio.dart';
import 'package:bonde_do_ru/src/start/start_bloc.dart';
import 'package:flutter/material.dart';
import 'alimento/alimento_repositorio.dart';
import 'app_bloc.dart';
import 'app_widget.dart';
import 'cardapio/cardapio_bloc.dart';
import 'cardapio/cardapio_repositorio.dart';


class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        // Bloc((i) => CardapioBloc()),
        // Bloc((i) => StartBloc()),
        Bloc((i) => AppBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => CardapioRepositorio()),
        Dependency((i) => AlimentoRepositorio()),
        Dependency((i) => MensagensRepositorio()),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
