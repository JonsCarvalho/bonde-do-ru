import 'package:bonde_do_ru/src/shared/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Horario extends BaseModel {
  String _documentId;
  String refeicao;
  TimeOfDay horarioInicio;
  TimeOfDay horarioTermino;

  Horario();

  Horario.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;
    this.refeicao = document.data["refeicao"];
    this.horarioInicio = document.data["horarioInicio"];
    this.horarioTermino = document.data["horarioTermino"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();

    map['refeicao'] = this.refeicao;
    map['horarioInicio'] = this.horarioInicio;
    map['horarioTermino'] = this.horarioTermino;

    return map;
  }

  @override
  String documentId() => _documentId;
}
