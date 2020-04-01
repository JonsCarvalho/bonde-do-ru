import 'package:bonde_do_ru/src/shared/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cardapio extends BaseModel {
  String _documentId;
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

  Cardapio();

  Cardapio.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;
    this.refeicao = document.data["refeicao"];
    this.inicio = document.data["inicio"];
    this.dia = document.data["dia"];
    this.data = document.data["data"];
    this.mes = document.data["mes"];
    this.ano = document.data["ano"];
    this.pratoPrincipal = document.data["pratoPrincipal"];
    this.guarnicao = document.data["guarnicao"];
    this.dieta = document.data["dieta"];
    this.saladaCrua = document.data["saladaCrua"];
    this.saladaCozida = document.data["saladaCozida"];
    this.bebida = document.data["bebida"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();

    map['refeicao'] = this.refeicao;
    map['inicio'] = this.inicio;
    map['dia'] = this.dia;
    map['data'] = this.data;
    map['mes'] = this.mes;
    map['ano'] = this.ano;
    map['pratoPrincipal'] = this.pratoPrincipal;
    map['guarnicao'] = this.guarnicao;
    map['dieta'] = this.dieta;
    map['saladaCrua'] = this.saladaCrua;
    map['saladaCozida'] = this.saladaCozida;
    map['bebida'] = this.bebida;

    return map;
  }

  @override
  String documentId() => _documentId;
}
