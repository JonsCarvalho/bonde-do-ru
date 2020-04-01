import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:bonde_do_ru/src/models/horario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class HorarioRepositorio extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('horarios');

  void add(Horario horario) => _collection.add(horario.toMap());

  void update(String documentId, Horario horario) =>
      _collection.document(documentId).updateData(horario.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Observable<List<Horario>> get schedule =>
      Observable(_collection.snapshots().map((query) => query.documents
          .map<Horario>((document) => Horario.fromMap(document))
          .toList()));

  @override
  void dispose() {}
}
