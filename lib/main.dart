import 'package:flutter/material.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import 'package:gamebuddy/widgets/FancyCard.dart';

import 'game_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameListScreen(),
    );
  }
}

class GameListScreen extends StatefulWidget {
  @override
  _GameListScreenState createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<Game> _games = [];

  @override
  void initState() {
    super.initState();
    fetchGames().then((games) {
      setState(() {
        _games = games;
      });
    }).catchError((error) {
      print('Failed to fetch games: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FancyAppBar(
        title: 'Game List',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ListView.builder(
          itemCount: _games.length,
          itemBuilder: (context, index) {
            final game = _games[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetailsPage(
                      gameId: game.gameId,
                    ),
                  ),
                );
              },
              child: FancyCard(
                title: 'Game ID: ${game.gameId}',
                gameType: game.gameType,
                location: game.location,
                gameDateTime: game.gameDateTime,
              ),
            );
          },
        ),
      ),
    );
  }
}
