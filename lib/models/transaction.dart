import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Transacation{
   String? id;
   String? title;
   double? value;
   late DateTime date;
  String? id_usuario;

  Transacation({
    this.id =null,
    required this.title,
    required this.date,
    required this.value,
    required this.id_usuario
  });

  Transacation.fromMap(Map<String, dynamic> map) {
    Timestamp data = map ["date"];
    title = map["title"];
    value = map["value"];
    date = data.toDate();
    id_usuario = map["id_usuario"];
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['date'] = this.date;
    data['id_usuario'] = this.id_usuario;
    return data;
  }
}