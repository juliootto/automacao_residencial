import 'package:automacao_residencial/screens/home.dart';
import 'package:flutter/material.dart';

// O ponto de entrada principal da aplicação Flutter.
void main() {
  runApp(const MyApp());
}

// MyApp é o widget raiz da aplicação.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Automação Residencial',
      theme: ThemeData(
        // Define o esquema de cores da aplicação, usando uma semente de cor.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 37, 141),
        ),
      ),
      home: const MyHomePage(title: 'Automação Residencial'),
    );
  }
}

