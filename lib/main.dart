import 'package:flutter/material.dart';
import 'games_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameListScreen(),
    );
  }
}
