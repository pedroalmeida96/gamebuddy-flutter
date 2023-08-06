import 'package:flutter/material.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import 'package:gamebuddy/widgets/FancyCard.dart';

import 'create_game.dart';
import 'game_details_page.dart';
import 'http/http.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({super.key});

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
      appBar: const FancyAppBar(
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
                onEdit: () {},
                onDelete: () {},
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddGame,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _handleAddGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateGamePage(),
      ),
    );
  }
}
