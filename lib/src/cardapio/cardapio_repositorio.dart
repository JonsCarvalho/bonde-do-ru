import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/cardapio_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class CardapioRepositorio extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('cardapio');

  void add(Cardapio cardapio) => _collection.add(cardapio.toMap());

  void update(String documentId, Cardapio cardapio) =>
      _collection.document(documentId).updateData(cardapio.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Observable<List<Cardapio>> get cardapio =>
      Observable(_collection.orderBy("inicio").snapshots().map((query) => query.documents
          .map<Cardapio>((document) => Cardapio.fromMap(document))
          .toList()));
  // Observable<List<Cardapio>> get cardapioQuery =>
  //     Observable(_collection.getDocuments() => query.documents
  //         .map<Cardapio>((document) => Cardapio.fromMap(document))
  //         .toList()));

  @override
  void dispose() {}
}
