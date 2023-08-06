import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamebuddy/http/http.dart';
import 'package:gamebuddy/widgets/FancyAppBar.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../model/game.dart';
import 'games_list.dart';
import 'model/appuser.dart';

class CreateGamePage extends StatefulWidget {
  @override
  _CreateGamePageState createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final TextEditingController _gameTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  List<AppUser> _users = [];
  AppUser? _selectedUser;

  @override
  void initState() {
    super.initState();
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
      appBar: const FancyAppBar(
        title: 'Create Game',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<AppUser>(
              value: _selectedUser,
              items: _users.map((user) {
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
            TextField(
              controller: _gameTypeController,
              decoration: const InputDecoration(
                labelText: 'Game Type',
              ),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            SizedBox(
              height: 125,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _selectedDateTime,
                onDateTimeChanged: (DateTime newDateTime) {
                  setState(() {
                    _selectedDateTime = newDateTime;
                  });
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
    );
  }

  void _handleAddGame() async {
    final uuid = Uuid();
    final String generatedUuid = uuid.v4();
    final gameId = generatedUuid.substring(0, 8);
    final game = Game(
      gameId: gameId,
      gameType: _gameTypeController.text,
      location: _locationController.text,
      gameDateTime: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
          .format(_selectedDateTime)
          .toString(),
      participants: [_selectedUser!],
    );

    try {
      await createGame(game);
      Fluttertoast.showToast(
        msg: 'New game created successfully',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GameListScreen(),
        ),
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error creating a game: $error',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      // Handle error condition appropriately
    }
  }

  @override
  void dispose() {
    _gameTypeController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
