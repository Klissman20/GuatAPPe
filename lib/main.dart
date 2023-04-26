import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guatappé',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Guatappé'),
        ),
        body: const Center(
          child: Text('GUIA AR'),
        ),
      ),
    );
  }
}
