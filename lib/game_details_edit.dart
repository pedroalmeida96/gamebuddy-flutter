import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';

import 'model/appuser.dart';

class GameDetailsEditPage extends StatefulWidget {
  final String gameId;

  const GameDetailsEditPage({Key? key, required this.gameId}) : super(key: key);

  @override
  GameDetailsEditPageState createState() => GameDetailsEditPageState();
}

class GameDetailsEditPageState extends State<GameDetailsEditPage> {
  late Future<Game> _gameFuture;
  late TextEditingController _gameTypeController;
  late TextEditingController _locationController;
  late TextEditingController _gameDateTimeController;
  List<AppUser> _users = [];
  AppUser? _selectedUser;

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGameById(widget.gameId);
    _gameTypeController = TextEditingController();
    _locationController = TextEditingController();
    _gameDateTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _gameTypeController.dispose();
    _locationController.dispose();
    _gameDateTimeController.dispose();
    super.dispose();
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
            _gameTypeController.text = game.gameType;
            _locationController.text = game.location;
            _gameDateTimeController.text = game.gameDateTime.toString();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Game ID:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    game.gameId, // Display the Game ID as text
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<AppUser>(
                    value: _selectedUser,
                    items: game.participants.map((user) {
                      return DropdownMenuItem<AppUser>(
                        value: user,
                        child: Text(user.name),
                      );
                    }).toList(),
                    onChanged: (user) {
                      setState(() {
                        _selectedUser = user;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Select User',
                    ),
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
                  TextFormField(
                    controller: _gameTypeController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
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
                  TextFormField(
                    controller: _locationController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
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
                  SizedBox(
                    height: 125,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: DateTime.parse(_gameDateTimeController
                          .text), // Use the _gameDateTimeController to initialize
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          _gameDateTimeController.text = newDateTime
                              .toString(); // Update the _gameDateTimeController
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 16, bottom: 16),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _handleEditGame(game.gameId);
                            },
                            icon: Icon(Icons.save), // Display the save icon
                            label: const Text(''), // Empty text
                          )),
                    ),
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

  void _handleEditGame(String gameId) {
    // Extract the edited data from the text controllers
    final String editedGameType = _gameTypeController.text;
    final String editedLocation = _locationController.text;
    final String editedGameDateTime = _gameDateTimeController.text;

    final updatedGame = Game(
        gameId: gameId,
        gameType: editedGameType,
        location: editedLocation,
        gameDateTime: editedGameDateTime,
        participants: []);

    print(updatedGame.toString());

    try {
      final update = updateGame(updatedGame);
      Fluttertoast.showToast(
        msg: 'New game created successfully',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error creating a game: $error',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    Navigator.pop(context);
  }
}
