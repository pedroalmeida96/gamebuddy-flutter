import 'package:flutter/material.dart';

class GameDetailsPage extends StatelessWidget {
  final String gameId;

  const GameDetailsPage({Key? key, required this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the layout for the game details page
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Details'),
      ),
      body: Center(
        child: Text('Game ID: $gameId'), // Display the game ID for now
      ),
    );
  }
}
