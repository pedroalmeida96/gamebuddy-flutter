import 'package:flutter/material.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';

class GameDetailsPage extends StatefulWidget {
  final String gameId;

  const GameDetailsPage({Key? key, required this.gameId}) : super(key: key);

  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  late Future<Game> _gameFuture;

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGameById(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FancyAppBar(title: 'Game Details'),
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
                  Text(
                    'Game ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    game.gameId,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Game Type:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    game.gameType,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Location:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    game.location,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Game DateTime:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    game.gameDateTime
                        .toString(), // Adjust the formatting as needed
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to fetch game details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
