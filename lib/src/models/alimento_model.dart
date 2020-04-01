import 'package:bonde_do_ru/src/shared/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Alimento extends BaseModel {
  String _documentId;
  String nome;
  String searchKey;
  String acucar;
  String calorias;
  String colesterol;
  String gorduraSaturada;
  String sodio;

  Alimento();

  Alimento.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;
    this.nome = document.data["nome"];
    this.searchKey = document.data["searchKey"];
    this.acucar = document.data["acucar"];
    this.calorias = document.data["calorias"];
    this.colesterol = document.data["colesterol"];
    this.gorduraSaturada = document.data["gorduraSaturada"];
    this.sodio = document.data["sodio"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['nome'] = this.nome;
    map['searchKey'] = this.searchKey;
    map['acucar'] = this.acucar;
    map['calorias'] = this.calorias;
    map['colesterol'] = this.colesterol;
    map['gorduraSaturada'] = this.gorduraSaturada;
    map['sodio'] = this.sodio;
    return map;
  }

  @override
  String documentId() => _documentId;
}
