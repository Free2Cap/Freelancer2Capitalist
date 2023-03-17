import 'package:flutter/material.dart';

class FirmInformation extends StatefulWidget {
  const FirmInformation({super.key});

  @override
  State<FirmInformation> createState() => _FirmInformationState();
}

class _FirmInformationState extends State<FirmInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Firm Information",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      
      
    );
    ;
  }
}
