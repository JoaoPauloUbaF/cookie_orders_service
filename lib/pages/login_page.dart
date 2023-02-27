import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  const LoginPage({
    super.key,
  });
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the home page after successful login
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(
            userCredential: userCredential,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Não há usuários com esse e-mail.';
      } else if (e.code == 'wrong-password') {
        message = 'Senha incorreta para este usuário.';
      } else {
        message = 'Ocorreu um erro ao logar: ${e.message}';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro de login'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              onPressed: _signInWithEmailAndPassword,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
