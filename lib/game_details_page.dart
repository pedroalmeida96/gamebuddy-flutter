import 'package:flutter/material.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';

class GameDetailsPage extends StatefulWidget {
  final String gameId;

  const GameDetailsPage({Key? key, required this.gameId}) : super(key: key);

  @override
  GameDetailsPageState createState() => GameDetailsPageState();
}

class GameDetailsPageState extends State<GameDetailsPage> {
  late Future<Game> _gameFuture;

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGameById(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FancyAppBar(
        title: 'Game Details',
      ),
      body: FutureBuilder<Game>(
        future: _gameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Game ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.gameId,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Game Type:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.gameType,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Location:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.location,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Game DateTime:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.gameDateTime
                        .toString(), // Adjust the formatting as needed
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Failed to fetch game details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}