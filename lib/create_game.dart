import 'package:flutter/material.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import '../model/game.dart';
import 'http/http.dart';

class CreateGamePage extends StatefulWidget {
  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final TextEditingController _gameTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _gameDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FancyAppBar(
        title: 'Create game',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _gameTypeController,
              decoration: const InputDecoration(
                labelText: 'Game Type',
              ),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            TextField(
              controller: _gameDateTimeController,
              decoration: const InputDecoration(
                labelText: 'Game Date Time',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleAddGame,
              child: const Text('Add Game'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddGame() async {
    final game = Game(
      gameId: '',
      gameType: _gameTypeController.text,
      location: _locationController.text,
      gameDateTime: _gameDateTimeController.text,
    );

    try {
      final createdGame = await createGame(game);
      print('New game created successfully: ${createdGame.gameId}');
      // Do any necessary navigation or further actions after game creation
    } catch (error) {
      print('Error creating a game: $error');
      // Handle error condition appropriately
    }
  }

  @override
  void dispose() {
    _gameTypeController.dispose();
    _locationController.dispose();
    _gameDateTimeController.dispose();
    super.dispose();
  }
}
