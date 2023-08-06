import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'game_details_page.dart';
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
  AppUser? _selectedUser;
  List<AppUser> _users = [];
  List<AppUser> _existingParticipants = [];
  List<AppUser> _selectedParticipants = [];

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGameById(widget.gameId);
    _gameTypeController = TextEditingController();
    _locationController = TextEditingController();
    _gameDateTimeController = TextEditingController();
    fetchUsers().then((users) {
      setState(() {
        _users = users;
      });
    }).catchError((error) {
      print('Failed to fetch users: $error');
    });
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
            _existingParticipants = game.participants;
            _existingParticipants.forEach((user) {
              print(user.name);
            });
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
                  const SizedBox(height: 16),
                  const Text(
                    'Participants:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  MultiSelectDialogField<AppUser>(
                    initialValue: _existingParticipants,
                    items: _users
                        .map(
                            (user) => MultiSelectItem<AppUser>(user, user.name))
                        .toList(),
                    onConfirm: (values) {
                      _selectedParticipants = values;
                    },
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

  Future<void> _handleEditGame(String gameId) async {
    // Extract the edited data from the text controllers
    final String editedGameType = _gameTypeController.text;
    final String editedLocation = _locationController.text;
    final String editedGameDateTime = _gameDateTimeController.text;

    final updatedGame = Game(
        gameId: gameId,
        gameType: editedGameType,
        location: editedLocation,
        gameDateTime: editedGameDateTime,
        participants: _selectedUser != null ? [_selectedUser!] : []);

    print(updatedGame.toString());

    try {
      final updatedGameResult = await updateGame(updatedGame);
      Fluttertoast.showToast(
        msg: 'Game updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GameDetailsPage(gameId: updatedGameResult.gameId)),
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error creating a game: $error',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  List<DropdownMenuItem<AppUser>> _buildDropdownItems() {
    return _users
        .map(
          (user) => DropdownMenuItem<AppUser>(
            value: user,
            child: Text(
              user.name,
              style: _existingParticipants.contains(user)
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null,
            ),
          ),
        )
        .toList();
  }
}
