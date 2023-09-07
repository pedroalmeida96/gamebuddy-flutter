import 'package:flutter/material.dart';

import '../http/http.dart';
import '../model/game.dart';
import '../model/token_manager.dart';
import '../widgets/gamebuddy_appbar.dart';
import '../widgets/gamebuddy_card.dart';
import '../widgets/toast_utils.dart';
import 'create_game.dart';
import 'game_details_edit.dart';
import 'game_details_page.dart';

class AuthoredGameListScreen extends StatefulWidget {
  const AuthoredGameListScreen({Key? key}) : super(key: key);

  @override
  _AuthoredGameListScreenState createState() => _AuthoredGameListScreenState();
}

class _AuthoredGameListScreenState extends State<AuthoredGameListScreen> {
  List<Game> _games = [];
  var loggedInUser = TokenManager.loggedInUser!;

  @override
  void initState() {
    super.initState();
    fetchGamesByAuthor(loggedInUser).then((games) {
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
                gameAuthor: game.author,
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
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
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
        _games.removeWhere((game) => game.gameId == gameId);
      });
    } catch (error) {
      showErrorToast('Error deleting the game: $error');
    }
  }
}
