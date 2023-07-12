import 'package:flutter/material.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyCard.dart';

import 'game_details_page.dart';

class GamesList extends StatelessWidget {
  final List<Game> games;

  const GamesList({Key? key, required this.games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
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
    );
  }
}