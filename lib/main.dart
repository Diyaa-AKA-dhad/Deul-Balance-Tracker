import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/balance_provider.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';
import 'screens/nicknames_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BalanceProvider(),
      child: MaterialApp(
        title: 'Balance Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => const HomeScreen(),
          '/history': (ctx) => const HistoryScreen(),
          '/nicknames': (ctx) => const NicknamesScreen(),
        },
      ),
    );
  }
}
