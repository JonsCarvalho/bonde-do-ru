import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/alimento_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AlimentoRepositorio extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('alimentos');

  void add(Alimento alimento) => _collection.add(alimento.toMap());

  void update(String documentId, Alimento alimento) =>
      _collection.document(documentId).updateData(alimento.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Observable<List<Alimento>> get alimentos =>
      Observable(_collection.orderBy("nome").snapshots().map((query) => query.documents
          .map<Alimento>((document) => Alimento.fromMap(document))
          .toList()));

  @override
  void dispose() {}
}
