import 'package:flutter/material.dart';
import 'package:pfps_platform/screens/screen_main.dart';

void main() {
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainScreen(),
    );
  }
}
