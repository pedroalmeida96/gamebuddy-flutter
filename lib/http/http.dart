import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/appuser.dart';
import '../model/game.dart';
import '../model/token_manager.dart';

const String baseUrl = 'http://10.0.2.2:8080/api/games';
var authToken = TokenManager.authToken!;

Future<List<Game>> fetchGames() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8080/api/games'),
    headers: {'Authorization': 'Bearer $authToken'},
  );
  if (response.statusCode == 200) {
    final List<dynamic> gamesJson = jsonDecode(response.body);
    return gamesJson.map((json) => Game.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch all games');
  }
}

Future<List<Game>> fetchGamesByAuthor(String author) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8080/api/games/byAuthor?author=$author'),
    headers: {'Authorization': 'Bearer $authToken'},
  );
  if (response.statusCode == 200) {
    final List<dynamic> gamesJson = jsonDecode(response.body);
    return gamesJson.map((json) => Game.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch all games from $author');
  }
}

Future<Game> fetchGameById(int gameId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8080/api/games/' + gameId.toString()),
    headers: {'Authorization': 'Bearer $authToken'},
  );
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final game = Game.fromJson(jsonData);
    print('Retrieved game: $game');
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
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      },
    );

    if (response.statusCode == 200) {
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

Future<Game> updateGame(Game game) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/games/update');

  try {
    final response = await http.put(
      url,
      body: json.encode(game.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      },
    );

    if (response.statusCode == 200) {
      final updatedGame = Game.fromJson(json.decode(response.body));
      return updatedGame;
    } else {
      throw Exception(
          'Failed to update the game. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error updating the game: $error');
  }
}

Future<void> deleteGame(int gameId) async {
  final url = Uri.parse('http://10.0.2.2:8080/api/games/delete/$gameId');
  try {
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $authToken'},
    );
    if (response.statusCode == 200) {
      print('Game deleted successfully');
    } else {
      print('Failed to delete game');
    }
  } catch (error) {
    print('Error deleting game: $error');
  }
}

Future<List<AppUser>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/users'),
      headers: {'Authorization': 'Bearer $authToken'});
  if (response.statusCode == 200) {
    final List<dynamic> appUsersJson = jsonDecode(response.body);
    return appUsersJson.map((json) => AppUser.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future<List<String>> fetchGameTypes() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8080/api/gameTypes'),
    headers: {'Authorization': 'Bearer $authToken'},
  );

  if (response.statusCode == 200) {
    print(response.body);
    final List<dynamic> gameTypesJson = jsonDecode(response.body);
    return gameTypesJson.map((json) => json.toString()).toList();
  } else {
    throw Exception('Failed to fetch gameTypes');
  }
}

Future<String> performLogin(String username, String password) async {
  final Uri loginUrl = Uri.parse('http://10.0.2.2:8080/login');
  print("username: " + username + "      pw: " + password);

  // Create a Map representing the request body
  final requestBody = {
    'username': username,
    'password': password,
  };

  // Print the request body as a JSON string
  final requestBodyJson = json.encode(requestBody);
  print("Request Body JSON: $requestBodyJson");

  final response = await http.post(
    loginUrl,
    headers: {'Content-Type': 'application/json'},
    body: requestBodyJson,
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Login failed');
  }
}

Future<String> performRegistration(
    String username, String name, String password) async {
  final Uri loginUrl = Uri.parse('http://10.0.2.2:8080/registration');
  final requestBody = {
    'username': username,
    'name': name,
    'password': password,
  };

  // Print the request body as a JSON string
  final requestBodyJson = json.encode(requestBody);
  print("Request Body JSON: $requestBodyJson");

  final response = await http.post(
    loginUrl,
    headers: {'Content-Type': 'application/json'},
    body: requestBodyJson,
  );

  if (response.statusCode == 200) {
    return "Ok";
  } else {
    throw Exception('Login failed');
  }
}
