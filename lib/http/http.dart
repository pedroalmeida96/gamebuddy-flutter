import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/game.dart';

const String baseUrl = 'http://10.0.2.2:8080/api/games';

Future<List<Game>> fetchGames() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/games'));
  if (response.statusCode == 200) {
    final List<dynamic> gamesJson = jsonDecode(response.body);
    return gamesJson.map((json) => Game.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch games');
  }
}

Future<Game> fetchGameById(String gameId) async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8080/api/games/' + gameId));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final game = Game.fromJson(
        jsonData); // Assuming you have a fromJson factory constructor in your Game class
    print('Retrieved game: ${game.gameDateTime}');
    return game;
  } else {
    throw Exception('Failed to fetch game');
  }
}

Future<Game> createGame(Game game) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/games/create');

  try {
    final response = await http.post(
      url,
      body: json.encode(game.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final createdGame = Game.fromJson(json.decode(response.body));
      return createdGame;
    } else {
      throw Exception(
          'Failed to create a game. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error creating a game: $error');
  }
}