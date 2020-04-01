import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/alimento/alimento_bloc.dart';
import 'package:bonde_do_ru/src/alimento/alimento_repositorio.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_bloc.dart';
import 'package:bonde_do_ru/src/cardapio/cardapio_repositorio.dart';
import 'package:flutter/material.dart';
import 'gerenciamento_bloc.dart';
import 'gerenciamento_page.dart';

class GerenciamentoModule extends ModuleWidget {
  final Function onTap;
  GerenciamentoModule(this.onTap);

  @override
  List<Bloc> get blocs => [
        Bloc((i) => GerenciamentoBloc()),
        Bloc((i) => CardapioBloc()),
        Bloc((i) => AlimentoBloc()),
        // Bloc((i) => AlimentoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        // Dependency((i) => CardapioRepositorio()),
        // Dependency((i) => AlimentoRepositorio()),
      ];

  @override
  Widget get view => GerenciamentoPage(onTap: onTap);

  static Inject get to => Inject<GerenciamentoModule>.of();
}
