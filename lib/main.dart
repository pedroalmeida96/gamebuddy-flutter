import 'package:flutter/material.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import 'package:gamebuddy/widgets/FancyCard.dart';

import 'create_game.dart';
import 'game_details_page.dart';
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