import 'package:expenses/telas/login_screen.dart';
import 'package:expenses/telas/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/models/usuario.dart';
import 'package:expenses/uteis/nav.dart';

class ControlOpeningScreen {
  void runApp(BuildContext context) {
    // Dando um tempo para exibição da tela de abertura
    Future future = Future.delayed(Duration(seconds: 2));

    future.then((value) => {
          // Obtendo o Usuário (caso já esteja logado)
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              push(context, LoginScreen(), replace: true);
            } else {
              Usuario usuario;
              FirebaseFirestore.instance
                  .collection('usuarios')
                  .where("email", isEqualTo: "${user.email}")
                  .snapshots()
                  .listen((data) {

                usuario = Usuario.fromMap(data.docs[0].data());
                usuario.id = data.docs[0].id;
                push(context, TransactionScreen(usuario), replace: true);
              });
            }
          })
        });
  }
}