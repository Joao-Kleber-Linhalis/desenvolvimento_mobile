import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/telas/transaction_screen.dart';
import 'package:expenses/uteis/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/usuario.dart';
import '../../uteis/nav.dart';

class ControlLoginScreen{
  final control_login = TextEditingController();
  final control_password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final focus_password = FocusNode();
  final focos_buton = FocusNode();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _collection_usuarios => FirebaseFirestore.instance.collection('usuarios');

  void login(BuildContext context) async{
    if(formkey.currentState!.validate()){
      String login = control_login.text.trim();
      String password = control_password.text.trim();

      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: login, 
          password: password
          );
          print("logado");
        _toMainsScreen(userCredential.user,context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AlertMessage(context, "Erro: Usuário não encontrado");
        } else if (e.code == 'wrong-password') {
          AlertMessage(context, "Erro: Senha inválida", );
        }
      }
    }
  }

  void _toMainsScreen(User? user, BuildContext context){
    _collection_usuarios.
      where("email", isEqualTo: "${user!.email}").snapshots().
      listen((data) {
        Usuario usuario = Usuario.fromMap(data.docs[0].data());
        usuario.id = data.docs[0].id;
        push(context, TransactionScreen(usuario), replace: true);
      });
  }

  void cadastrar(BuildContext context) async{
    if (formkey.currentState!.validate()){
      String login = control_login.text.trim();
      String password = control_password.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: login,
            password: password
        );

        // No serviço de armazenamento
        _collection_usuarios.add({
          'email': login,
        }).then((value) => _toMainsScreen(userCredential.user, context))
          .catchError((error) => print("Falha ao adicionar o usuário: $error"));


      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AlertMessage(context, "Erro: A senha fornecida é muito fraca");
        } else if (e.code == 'email-already-in-use') {
          AlertMessage(context, "Erro: Já existe conta com o email informado");
        }
      } catch (e) {
        print(e);
      }
    }
  }

}