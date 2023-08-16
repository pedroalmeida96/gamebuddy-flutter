import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../http/http.dart';
import '../model/token_manager.dart';
import '../widgets/gamebuddy_appbar.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GamebuddyAppBar(
        title: 'Login',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
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
                  Navigator.pushReplacementNamed(context, '/gameList');
                } catch (e) {
                  print('Error during login: $e');
                }
              },
              child: const Text('Login'),
            ),
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
