import 'package:flutter/foundation.dart';

class Transacation{
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transacation({
    required this.id,
    required this.title,
    required this.date,
    required this.value
  });
}