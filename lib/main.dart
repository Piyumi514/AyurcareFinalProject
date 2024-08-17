import 'package:ayurcare/pages/connecting_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() async{

WidgetsFlutterBinding.ensureInitialized();

 if(kIsWeb){
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyAFQ7brMgMHoyw8yeY8tOqUQCnkHQrCA5s",
  authDomain: "ayurcaregrp12-27423.firebaseapp.com",
  projectId: "ayurcaregrp12-27423",
  storageBucket: "ayurcaregrp12-27423.appspot.com",
  messagingSenderId: "834846528345",
  appId: "1:834846528345:web:429bfeb4d6bd1652797248"));
  runApp(const MyApp());
 }
else{
  await Firebase.initializeApp();
}
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConnectingPage(),
    );
  }
}