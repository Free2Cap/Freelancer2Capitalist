import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/login");
        },
        child: Text("back"),
      )),
    );
  }
}
