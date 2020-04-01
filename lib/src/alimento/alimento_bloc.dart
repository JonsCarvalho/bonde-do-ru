import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/alimento_model.dart';
import 'package:rxdart/rxdart.dart';
import '../app_module.dart';
import 'alimento_repositorio.dart';

class AlimentoBloc extends BlocBase {
  String documentId;
  String nome;
  String searchKey;
  String acucar;
  String calorias;
  String colesterol;
  String gorduraSaturada;
  String sodio;

  AlimentoBloc() {
    _nomeController.listen((value) => nome = value);
    _searchKeyController.listen((value) => searchKey = value);
    _acucarController.listen((value) => acucar = value);
    _caloriasController.listen((value) => calorias = value);
    _colesterolController.listen((value) => colesterol = value);
    _gorduraSaturadaController.listen((value) => gorduraSaturada = value);
    _sodioController.listen((value) => sodio = value);
  }

  var _repository = AppModule.to.getDependency<AlimentoRepositorio>();

  void setAlimento(Alimento alimento) {
    documentId = alimento.documentId();
    setNome(alimento.nome);
    setSearchKey(alimento.searchKey);
    setAcucar(alimento.acucar);
    setColesterol(alimento.colesterol);
    setCalorias(alimento.calorias);
    setGorduraSaturada(alimento.gorduraSaturada);
    setSodio(alimento.sodio);
  }

  var _nomeController = BehaviorSubject<String>();
  Stream<String> get outNome => _nomeController.stream;
  var _searchKeyController = BehaviorSubject<String>();
  Stream<String> get outSearchKey => _searchKeyController.stream;
  var _acucarController = BehaviorSubject<String>();
  Stream<String> get outAcucar => _acucarController.stream;
  var _caloriasController = BehaviorSubject<String>();
  Stream<String> get outCalorias => _caloriasController.stream;
  var _colesterolController = BehaviorSubject<String>();
  Stream<String> get outColesterol => _colesterolController.stream;
  var _gorduraSaturadaController = BehaviorSubject<String>();
  Stream<String> get outGorduraSaturada => _gorduraSaturadaController.stream;
  var _sodioController = BehaviorSubject<String>();
  Stream<String> get outSodio => _sodioController.stream;

  void setNome(String value) => _nomeController.sink.add(value);
  void setSearchKey(String value) => _searchKeyController.sink.add(value);
  void setAcucar(String value) => _acucarController.sink.add(value);
  void setCalorias(String value) => _caloriasController.sink.add(value);
  void setColesterol(String value) => _colesterolController.sink.add(value);
  void setGorduraSaturada(String value) =>
      _gorduraSaturadaController.sink.add(value);
  void setSodio(String value) => _sodioController.sink.add(value);

  bool insertOrUpdate() {
    var alimento = Alimento()
      ..nome = this.nome
      ..searchKey = this.searchKey
      ..acucar = this.acucar
      ..colesterol = this.colesterol
      ..calorias = this.calorias
      ..gorduraSaturada = this.gorduraSaturada
      ..sodio = this.sodio;

    if (documentId?.isEmpty ?? true) {
      _repository.add(alimento);
    } else {
      _repository.update(documentId, alimento);
    }
    return true;
  }

  @override
  void dispose() {
    _nomeController.close();
    _searchKeyController.close();
    _acucarController.close();
    _caloriasController.close();
    _colesterolController.close();
    _gorduraSaturadaController.close();
    _sodioController.close();

    super.dispose();
  }
}
