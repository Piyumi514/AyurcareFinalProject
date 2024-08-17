import 'package:ayurcare/pages/connecting_page.dart';
import 'package:ayurcare/pages/login.dart';
import 'package:ayurcare/pages/submit_page.dart';
import 'package:ayurcare/util/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  FutureBuilder<User?>(
        future: AuthService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            // User is signed in
            return MyPage();
          } else {
            // No user is signed in
            return ConnectingPage();
          }
        },
      ),
    );
  }
}
