import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamebuddy/widgets/gamebuddy_button.dart';
import 'package:gamebuddy/widgets/gamebuddy_textfield.dart';

import '../http/http.dart';
import '../model/token_manager.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Login to your account",
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
              controller: _passwordController,
              isEnabled: true,
              obscureText: true,
              labelText: 'Password',
            ),
            const SizedBox(height: 16),
            GamebuddyButton(
                onPressed: () async {
                  try {
                    final token = await performLogin(
                        _emailController.text, _passwordController.text);
                    TokenManager.authToken = token;
                    if (TokenManager.authToken != null) {
                      Fluttertoast.showToast(
                        msg: 'Auth token retrieved!',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    }
                    Navigator.pushReplacementNamed(context, '/menu');
                  } catch (e) {
                    print('Error during login: $e');
                  }
                },
                buttonText: 'Sign in',
                icon: const Icon(Icons.login)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration page
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
