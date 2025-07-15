import 'package:flutter/material.dart';
import 'screens/marcas_screen.dart';

void main() {
  runApp(const JPApp());
}

class JPApp extends StatelessWidget {
  const JPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JP Peças',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MarcasScreen(),
    );
  }
}