import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/models/usuario.dart';
import 'package:expenses/uteis/nav.dart';

class ControlTransaction{
  Usuario user;

  ControlTransaction(this.user);

  CollectionReference<Map<String, dynamic>> get _collection_transaction => FirebaseFirestore.instance.collection('transactions');
  Stream<QuerySnapshot> get stream => _collection_transaction.where("id_usuario", isEqualTo: user.id).snapshots();

  void _insert_transaction(Transacation transacation){

    DocumentReference docref = _collection_transaction.doc();
    docref.set(transacation.toMap());
  }

  void insert(Transacation transacation){
    _insert_transaction(transacation);
  }

}