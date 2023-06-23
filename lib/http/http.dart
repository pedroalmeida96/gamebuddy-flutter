import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/game.dart';

Future<List<Game>> fetchGames() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/games'));
  if (response.statusCode == 200) {
    final List<dynamic> gamesJson = jsonDecode(response.body);
    return gamesJson.map((json) => Game.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch games');
  }
}