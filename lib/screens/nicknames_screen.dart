import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/balance_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/person_settings.dart';

class NicknamesScreen extends StatelessWidget {
  const NicknamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Nicknames & Colors')),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PersonSettings(person: provider.PersonOne, isGirl: true),
            PersonSettings(person: provider.PersonTwo, isGirl: false),
          ],
        ),
      ),
    );
  }
}
