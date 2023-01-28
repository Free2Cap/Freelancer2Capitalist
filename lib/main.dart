import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freelancer2capitalist/pages/dashboard.dart';
import 'package:freelancer2capitalist/pages/login.dart';
import 'package:freelancer2capitalist/pages/registration.dart';

import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    title: "Freelancer2Capitalist",
    home: Home(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    routes: {
      "/login": (context) => Login(),
      "/registration": (context) => Registration(),
      "/dashboard": (context) => Dashboard(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Login();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
