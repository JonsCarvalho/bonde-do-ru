import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:rxdart/rxdart.dart';
import '../app_module.dart';
import 'cardapio_repositorio.dart';

class CardapioBloc extends BlocBase {
  String refeicao;
  String inicio;
  String dia;
  String data;
  String mes;
  String ano;
  String pratoPrincipal;
  String guarnicao;
  String dieta;
  String saladaCrua;
  String saladaCozida;
  String bebida;
  String documentId;

  CardapioBloc() {
    _refeicaoController.listen((value) => refeicao = value);
    _inicioController.listen((value) => inicio = value);
    _diaController.listen((value) => dia = value);
    _dataController.listen((value) => data = value);
    _mesController.listen((value) => mes = value);
    _anoController.listen((value) => ano = value);
    _pratoPrincipalController.listen((value) => pratoPrincipal = value);
    _guarnicaoController.listen((value) => guarnicao = value);
    _dietaController.listen((value) => dieta = value);
    _saladaCruaController.listen((value) => saladaCrua = value);
    _saladaCozidaController.listen((value) => saladaCozida = value);
    _bebidaController.listen((value) => bebida = value);
  }

  var _repository = AppModule.to.getDependency<CardapioRepositorio>();

  void setCardapio(Cardapio cardapio) {
    documentId = cardapio.documentId();
    setRefeicao(cardapio.refeicao);
    setInicio(cardapio.inicio);
    setDia(cardapio.dia);
    setData(cardapio.data);
    setMes(cardapio.mes);
    setAno(cardapio.ano);
    setPratoPrincipal(cardapio.pratoPrincipal);
    setGuarnicao(cardapio.guarnicao);
    setDieta(cardapio.dieta);
    setSaladaCrua(cardapio.saladaCrua);
    setSaladaCozida(cardapio.saladaCozida);
    setBebida(cardapio.bebida);
  }

  var _refeicaoController = BehaviorSubject<String>();
  Stream<String> get outRefeicao => _refeicaoController.stream;
  var _inicioController = BehaviorSubject<String>();
  Stream<String> get outInicio => _inicioController.stream;
  var _diaController = BehaviorSubject<String>();
  Stream<String> get outDia => _diaController.stream;
  var _dataController = BehaviorSubject<String>();
  Stream<String> get outData => _dataController.stream;
  var _mesController = BehaviorSubject<String>();
  Stream<String> get outMes => _mesController.stream;
  var _anoController = BehaviorSubject<String>();
  Stream<String> get outAno => _anoController.stream;
  var _pratoPrincipalController = BehaviorSubject<String>();
  Stream<String> get outPratoPrincipal => _pratoPrincipalController.stream;
  var _guarnicaoController = BehaviorSubject<String>();
  Stream<String> get outGuarnicao => _guarnicaoController.stream;
  var _dietaController = BehaviorSubject<String>();
  Stream<String> get outDieta => _dietaController.stream;
  var _saladaCruaController = BehaviorSubject<String>();
  Stream<String> get outSaladaCrua => _saladaCruaController.stream;
  var _saladaCozidaController = BehaviorSubject<String>();
  Stream<String> get outSaladaCozida => _saladaCozidaController.stream;
  var _bebidaController = BehaviorSubject<String>();
  Stream<String> get outBebida => _bebidaController.stream;

  void setRefeicao(String value) => _refeicaoController.sink.add(value);
  void setInicio(String value) => _inicioController.sink.add(value);
  void setDia(String value) => _diaController.sink.add(value);
  void setData(String value) => _dataController.sink.add(value);
  void setMes(String value) => _mesController.sink.add(value);
  void setAno(String value) => _anoController.sink.add(value);
  void setPratoPrincipal(String value) =>
      _pratoPrincipalController.sink.add(value);
  void setGuarnicao(String value) => _guarnicaoController.sink.add(value);
  void setDieta(String value) => _dietaController.sink.add(value);
  void setSaladaCrua(String value) => _saladaCruaController.sink.add(value);
  void setSaladaCozida(String value) => _saladaCozidaController.sink.add(value);
  void setBebida(String value) => _bebidaController.sink.add(value);

  bool insertOrUpdate() {
    var cardapio = Cardapio()
      ..refeicao = this.refeicao
      ..inicio = this.inicio
      ..dia = this.dia
      ..data = this.data
      ..mes = this.mes
      ..ano = this.ano
      ..pratoPrincipal = this.pratoPrincipal
      ..guarnicao = this.guarnicao
      ..dieta = this.dieta
      ..saladaCrua = this.saladaCrua
      ..saladaCozida = this.saladaCozida
      ..bebida = this.bebida;

    if (documentId?.isEmpty ?? true) {
      _repository.add(cardapio);
    } else {
      _repository.update(documentId, cardapio);
    }
    return true;
  }

  @override
  void dispose() {
    _refeicaoController.close();
    _inicioController.close();
    _diaController.close();
    _dataController.close();
    _mesController.close();
    _anoController.close();
    _pratoPrincipalController.close();
    _guarnicaoController.close();
    _dietaController.close();
    _saladaCruaController.close();
    _saladaCozidaController.close();
    _bebidaController.close();

    super.dispose();
  }
}
