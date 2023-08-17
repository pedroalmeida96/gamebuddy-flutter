import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/model/game.dart';
import 'package:gamebuddy/widgets/gamebuddy_appbar.dart';
import 'package:gamebuddy/widgets/gamebuddy_textfield.dart';
import 'package:gamebuddy/widgets/toast_utils.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'game_details_page.dart';
import '../model/appuser.dart';

class GameDetailsEditPage extends StatefulWidget {
  final int gameId;

  const GameDetailsEditPage({Key? key, required this.gameId}) : super(key: key);

  @override
  GameDetailsEditPageState createState() => GameDetailsEditPageState();
}

class GameDetailsEditPageState extends State<GameDetailsEditPage> {
  late Future<Game> _gameFuture;
  late TextEditingController _locationController;
  late TextEditingController _gameDateTimeController;
  late TextEditingController _auxController;
  List<String> _gameTypes = [];
  String? _selectedGameType;
  List<AppUser> _users = [];
  List<AppUser> _selectedParticipants = [];

  @override
  void initState() {
    super.initState();
    _gameFuture = fetchGameById(widget.gameId);
    _locationController = TextEditingController();
    _gameDateTimeController = TextEditingController();
    _auxController = TextEditingController();

    // Fetch game types and users
    fetchGameTypes().then((gameTypes) {
      setState(() {
        _gameTypes = gameTypes;
      });
    }).catchError((error) {
      print('Failed to fetch gameTypes: $error');
    });

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
    _locationController.dispose();
    _gameDateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GamebuddyAppBar(
        title: 'Game Details',
      ),
      body: FutureBuilder<Game>(
        future: _gameFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final game = snapshot.data!;
            // Set initial values for fields
            _locationController.text = game.location;
            _gameDateTimeController.text = game.gameDateTime.toString();
            _selectedParticipants = game.participants;
            _selectedGameType = game.gameType;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Game ID:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          game.gameId.toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    // Participants selection
                    const SizedBox(height: 16),
                    const Text(
                      'Participants:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MultiSelectDialogField<AppUser>(
                      initialValue: _selectedParticipants,
                      items: _users
                          .map((user) =>
                              MultiSelectItem<AppUser>(user, user.name))
                          .toList(),
                      onConfirm: (values) {
                        _selectedParticipants = values;
                      },
                    ),
                    // Game Type dropdown
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedGameType,
                      items: _gameTypes.map((gameType) {
                        return DropdownMenuItem<String>(
                          value: gameType,
                          child: Text(gameType),
                        );
                      }).toList(),
                      onChanged: (gameType) {
                        _selectedGameType = gameType;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select Game Type',
                      ),
                    ),
                    // Location text input
                    const SizedBox(height: 16),
                    GamebuddyTextField(
                      controller: _locationController,
                      isEnabled: true,
                      labelText: 'Location',
                    ),
                    // Date and Time picker
                    const SizedBox(height: 16),
                    const Text(
                      'Game DateTime:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 125,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime:
                            DateTime.parse(_gameDateTimeController.text),
                        onDateTimeChanged: (DateTime newDateTime) {
                          _gameDateTimeController.text =
                              DateFormat('yyyy-MM-ddTHH:mm:ss')
                                  .format(newDateTime);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    GamebuddyTextField(
                      controller: _auxController,
                      isEnabled: false,
                      labelText: 'Author',
                      initialText: game.author,
                    ),
                    // Save button
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final updatedGame = Game(
                              gameId: game.gameId,
                              gameType: _selectedGameType!,
                              location: _locationController.text,
                              gameDateTime: _gameDateTimeController.text,
                              participants: _selectedParticipants,
                              version: game.version);
                          print("updated game: $updatedGame");
                          _handleEditGame(updatedGame);
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                    ),
                  ],
                ),
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

  Future<void> _handleEditGame(Game updatedGame) async {
    try {
      final updatedGameResult = await updateGame(updatedGame);
      showSuccessToast("Game updated successfully");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GameDetailsPage(gameId: updatedGameResult.gameId!),
        ),
      );
    } catch (error) {
      showErrorToast("Error updating the game: $error");
    }
  }
}
