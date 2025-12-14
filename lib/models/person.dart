import 'dart:ui';
import 'transaction.dart';

class Person {
  String name;
  double balance;
  Color color;
  List<Transaction> transactions;

  Person({
    required this.name,
    this.balance = 0.0,
    required this.color,
    List<Transaction>? transactions,
  }) : transactions = transactions ?? [];
}
