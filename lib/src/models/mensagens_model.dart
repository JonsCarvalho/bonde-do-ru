import 'package:bonde_do_ru/src/shared/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mensagens extends BaseModel {
  String _documentId;
  String mensagem;
  DateTime horario;
  String nomeUsuario;
  String imageUsuario;

  Mensagens();

  Mensagens.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;
    this.mensagem = document.data["mensagem"];

    this.nomeUsuario = document.data["nomeUsuario"];
    this.imageUsuario = document.data["imageUsuario"];

    Timestamp timestamp = document.data["horario"];
    this.horario =
        DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();

    map['mensagem'] = this.mensagem;
    map['horario'] = this.horario;
    map['nomeUsuario'] = this.nomeUsuario;
    map['imageUsuario'] = this.imageUsuario;
    return map;
  }

  @override
  String documentId() => _documentId;
}
