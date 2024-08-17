// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:core';

import 'package:ayurcare/pages/home.dart';
import 'package:ayurcare/pages/submit_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/ac.png',
                fit: BoxFit.contain,
                height: 250,
                width: 180,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 25, 155, 31),
                  Color.fromARGB(255, 19, 48, 20)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 170,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Welcome to AyurCare',
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 137, 29),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    'assets/login_profile.jpg',
                    fit: BoxFit.contain,
                    height: 100,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
                const LoginForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  _emailError = value.isNotEmpty && !isValidEmail(value)
                      ? 'Please enter a valid email'
                      : null;
                });
              },
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _emailError,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: _passwordController,
              onChanged: (value) {
                setState(() {
                  _passwordError =
                      value.isEmpty ? 'Please enter password' : null;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                errorText: _passwordError,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final email = _emailController.text;
              final password = _passwordController.text;
              if (email.isEmpty || password.isEmpty) {
                setState(() {
                  _emailError = email.isEmpty ? 'Please enter email' : null;
                  _passwordError =
                      password.isEmpty ? 'Please enter password' : null;
                });
              } else if (!isValidEmail(email)) {
                setState(() {
                  _emailError = 'Please enter a valid email';
                });
              } else {
                // Proceed with login logic
                print('Email: $email');
                print('Password: $password');
                // Navigate to the next page after login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPage()),
                );
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green[900]!), // Dark green color
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white), // Text color set to white
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
