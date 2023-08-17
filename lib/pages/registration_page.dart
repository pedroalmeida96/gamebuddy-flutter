import 'package:flutter/material.dart';
import 'package:gamebuddy/widgets/gamebuddy_button.dart';

import '../http/http.dart';
import '../widgets/gamebuddy_textfield.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/logo.png', // Replace with your image asset path
              height: 250, // Adjust the height as needed
            ),
            const SizedBox(height: 16),
            const Text(
              "Create your account",
              style: TextStyle(
                fontSize: 24, // Adjust the font size as needed
                fontWeight: FontWeight
                    .bold, // You can also adjust the font weight if needed
              ),
            ),
            const SizedBox(height: 16),
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
                buttonText: 'Sign up',
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
