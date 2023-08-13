import 'package:flutter/material.dart';
import 'package:gamebuddy/pages/games_list.dart'; // Import your game list page

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Perform registration logic here
                // After successful registration, navigate to the GameListScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameListScreen()),
                );
              },
              child: const Text('Register'),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Navigate to the login page
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
