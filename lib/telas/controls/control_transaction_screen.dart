import 'package:expenses/models/usuario.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/telas/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../uteis/nav.dart';

class ControlTransactionScreen{
  Usuario user;
  List<Transacation>? transactions;
  List<DocumentSnapshot>? document_transactions;

  ControlTransactionScreen(this.user);

  CollectionReference<Map<String, dynamic>> get _collection_transaction => FirebaseFirestore.instance.collection('transactions');
  Stream<QuerySnapshot> get stream => _collection_transaction.where("id_usuario", isEqualTo: user.id).snapshots();


  void getTransactions(QuerySnapshot data){
    document_transactions = data.docs;
    transactions = document_transactions!.map((DocumentSnapshot  document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return Transacation.fromMap(data);
    }).toList();
  }

  void exit(BuildContext context){
    FirebaseAuth.instance.signOut();
    push(context, LoginScreen(), replace: true);
  }


 void deleteTransaction(int index){
    DocumentSnapshot documentSnapshot = document_transactions![index];
    documentSnapshot.reference.delete();
  }



}