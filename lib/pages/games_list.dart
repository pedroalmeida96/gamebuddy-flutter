import 'package:flutter/material.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/gamebuddy_appbar.dart';
import 'package:gamebuddy/widgets/gamebuddy_card.dart';
import 'package:gamebuddy/widgets/toast_utils.dart';

import 'create_game.dart';
import 'game_details_edit.dart';
import 'game_details_page.dart';
import '../http/http.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  _GameListScreenState createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<Game> _games = [];

  @override
  void initState() {
    super.initState();
    fetchGames().then((games) {
      print('Fetched games: $games');
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
      appBar: const GamebuddyAppBar(
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
                      gameId: game.gameId!,
                    ),
                  ),
                );
              },
              child: GamebuddyCard(
                title: 'Game ID: ${game.gameId}',
                gameType: game.gameType,
                location: game.location,
                gameDateTime: game.gameDateTime,
                onEdit: () {
                  print("edit");
                  _handleEditGame(game.gameId!);
                },
                onDelete: () {
                  _handleDeleteGame(game.gameId!);
                },
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

  void _handleEditGame(int gameId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailsEditPage(gameId: gameId),
      ),
    );
  }

  Future<void> _handleDeleteGame(int gameId) async {
    try {
      await deleteGame(gameId);
      showSuccessToast('Game deleted successfully');
      setState(() {
        // Remove the deleted game from the list of games
        _games.removeWhere((game) => game.gameId == gameId);
      });
    } catch (error) {
      showErrorToast('Error deleting the game: $error');
    }
  }
}
