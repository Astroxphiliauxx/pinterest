import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinterest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE60023)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Pinterest Clone — Day 1 Setup ✅')),
      ),
    );
  }
}
