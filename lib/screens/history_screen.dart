import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/transaction_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context);
    final persons = [provider.PersonOne, provider.PersonTwo];

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      drawer: const AppDrawer(),
      body: TransactionList(person: persons[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: persons.map((person) {
          return BottomNavigationBarItem(
            icon: Icon(Icons.person, color: person.color),
            label: person.name,
          );
        }).toList(),
        selectedItemColor: persons[_selectedIndex].color,
      ),
    );
  }
}
