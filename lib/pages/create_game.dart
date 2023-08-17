import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/widgets/gamebuddy_appbar.dart';
import 'package:gamebuddy/widgets/toast_utils.dart';
import 'package:intl/intl.dart';
import '../model/game.dart';
import '../model/appuser.dart';
import '../widgets/gamebuddy_dropdown.dart';
import '../widgets/gamebuddy_textfield.dart';

class CreateGamePage extends StatefulWidget {
  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final TextEditingController _locationController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  List<AppUser> _users = [];
  AppUser? _selectedUser;

  List<String> _gameTypes = [];
  String? _selectedGameType;

  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GamebuddyAppBar(
          title: 'Create Game',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 16),
                GamebuddyDropdown<AppUser>(
                  value: _selectedUser,
                  items: _users.map((user) {
                    return DropdownMenuItem<AppUser>(
                      value: user,
                      child: Text(user.name),
                    );
                  }).toList(),
                  onChanged: (user) {
                    _selectedUser = user;
                  },
                  labelText: 'Select User',
                ),
                const SizedBox(height: 16),
                GamebuddyDropdown<String>(
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
                  labelText: 'Select Game Type',
                ),
                const SizedBox(height: 16),
                GamebuddyTextField(
                  controller: _locationController,
                  isEnabled: true,
                  labelText: 'Location',
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 125,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _selectedDateTime,
                    onDateTimeChanged: (DateTime newDateTime) {
                      _selectedDateTime = newDateTime;
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _handleAddGame,
                  child: const Text('Add Game'),
                ),
              ],
            ),
          ),
        ));
  }

  void _handleAddGame() async {
    final game = Game(
        gameType: _selectedGameType!,
        location: _locationController.text,
        gameDateTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
            .format(_selectedDateTime)
            .toString(),
        participants: [_selectedUser!]);

    try {
      await createGame(game);
      showSuccessToast('New game created successfully');
      Navigator.pushReplacementNamed(context, '/gameList');
    } catch (error) {
      showErrorToast('Error creating a game: $error');
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
