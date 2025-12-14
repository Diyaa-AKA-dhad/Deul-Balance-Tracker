import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/person.dart';
import '../models/transaction.dart';

class BalanceProvider with ChangeNotifier {
  Person PersonOne = Person(
    name: 'Person 1',
    color: const Color(0xFFE91E63), // Pink
  );

  Person PersonTwo = Person(
    name: 'Person 2',
    color: const Color(0xFF2196F3), // Blue
  );

  List<String> girlNicknames = [];
  List<String> boyNicknames = [];

  final List<Color> availableColors = [
    const Color(0xFFE91E63), // Pink
    const Color(0xFF2196F3), // Blue
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF673AB7), // Deep Purple
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF00BCD4), // Cyan
    const Color(0xFF009688), // Teal
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFFC107), // Amber
    const Color(0xFFFF5722), // Deep Orange
  ];

  BalanceProvider() {
    _loadNicknames();
  }

  Future<void> _loadNicknames() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/nicknames.json',
      );
      final data = json.decode(response);
      girlNicknames = List<String>.from(data['girlNicknames']);
      boyNicknames = List<String>.from(data['boyNicknames']);
      notifyListeners();
    } catch (e) {
      print('Error loading nicknames: $e');
    }
  }

  void addTransaction(Person person, double amount) {
    final transaction = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      date: DateTime.now(),
    );
    person.transactions.insert(0, transaction);
    person.balance += amount;
    notifyListeners();
  }

  void deleteTransaction(Person person, String transactionId) {
    final transactionIndex = person.transactions.indexWhere(
      (t) => t.id == transactionId,
    );
    if (transactionIndex != -1) {
      final transaction = person.transactions[transactionIndex];
      person.balance -= transaction.amount;
      person.transactions.removeAt(transactionIndex);
      notifyListeners();
    }
  }

  void updateName(Person person, String newName) {
    person.name = newName;
    notifyListeners();
  }

  void updateColor(Person person, Color newColor) {
    person.color = newColor;
    notifyListeners();
  }

  List<String> getSuggestions(bool isGirl) {
    final list = isGirl ? girlNicknames : boyNicknames;
    if (list.isEmpty) return [];
    final random = Random();
    final suggestions = <String>{};
    while (suggestions.length < 2 && suggestions.length < list.length) {
      suggestions.add(list[random.nextInt(list.length)]);
    }
    return suggestions.toList();
  }
}
