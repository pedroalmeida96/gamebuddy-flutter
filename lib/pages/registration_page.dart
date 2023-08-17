import 'package:flutter/material.dart';
import 'package:gamebuddy/widgets/gamebuddy_button.dart';

import '../http/http.dart';
import '../widgets/gamebuddy_appbar.dart';
import '../widgets/gamebuddy_textfield.dart'; // Import your game list page

class RegistrationPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GamebuddyAppBar(
        title: 'Registration',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GamebuddyTextField(
              controller: _emailController,
              isEnabled: true,
              labelText: 'User',
            ),
            const SizedBox(height: 16),
            GamebuddyTextField(
              controller: _nameController,
              isEnabled: true,
              labelText: 'Name',
            ),
            const SizedBox(height: 16),
            GamebuddyTextField(
              controller: _passwordController,
              isEnabled: true,
              obscureText: true,
              labelText: 'Password',
            ),
            const SizedBox(height: 16),
            GamebuddyButton(
                onPressed: () {
                  performRegistration(_emailController.text,
                      _nameController.text, _passwordController.text);
                  Navigator.pushReplacementNamed(context, '/login');
                },
                buttonText: 'Register',
                icon: const Icon(Icons.account_circle)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration page
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Login'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
