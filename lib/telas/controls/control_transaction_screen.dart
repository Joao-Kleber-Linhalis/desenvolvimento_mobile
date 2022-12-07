import 'package:expenses/models/usuario.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlTransactionScreen{
  Usuario user;
  List<Transacation>? transactions;
  List<DocumentSnapshot>? document_transactions;

  ControlTransactionScreen(this.user);


}