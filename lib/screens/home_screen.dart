import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/person_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('The Bank of "Whatever"'), // Funny name
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PersonCard(person: provider.PersonOne),
            PersonCard(person: provider.PersonTwo),
          ],
        ),
      ),
    );
  }
}
