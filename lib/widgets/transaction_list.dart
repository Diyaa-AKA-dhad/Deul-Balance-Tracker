import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../providers/balance_provider.dart';

class TransactionList extends StatelessWidget {
  final Person person;

  const TransactionList({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    if (person.transactions.isEmpty) {
      return const Center(child: Text('No transactions yet.'));
    }

    return ListView.builder(
      itemCount: person.transactions.length,
      itemBuilder: (context, index) {
        final transaction = person.transactions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: person.color.withOpacity(0.2),
              child: Text(
                DateFormat('E')
                    .format(transaction.date)
                    .substring(0, 1), // First letter of day
                style: TextStyle(color: person.color),
              ),
            ),
            title: Text(
              '+${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: person.color,
              ),
            ),
            subtitle: Text(
              '${DateFormat('EEEE').format(transaction.date)} - ${DateFormat('d/M').format(transaction.date)}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Provider.of<BalanceProvider>(
                  context,
                  listen: false,
                ).deleteTransaction(person, transaction.id);
              },
            ),
          ),
        );
      },
    );
  }
}
