import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bonde_do_ru/src/models/mensagens_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class MensagensRepositorio extends Disposable {
  CollectionReference _collection = Firestore.instance.collection('mensagens');

  void add(Mensagens mensagens) => _collection.add(mensagens.toMap());

  void update(String documentId, Mensagens mensagens) =>
      _collection.document(documentId).updateData(mensagens.toMap());

  void delete(String documentId) => _collection.document(documentId).delete();

  Observable<List<Mensagens>> get mensagens => Observable(_collection
      .orderBy("horario", descending: true)
      .snapshots()
      .map((query) => query.documents
          .map<Mensagens>((document) => Mensagens.fromMap(document))
          .toList()));
  @override
  void dispose() {}
}
