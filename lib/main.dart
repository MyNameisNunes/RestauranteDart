import 'package:flutter/material.dart';
import 'telas/tela_prato_principal.dart';

void main() {
  runApp(const RestauranteApp());
}

class RestauranteApp extends StatelessWidget {
  const RestauranteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante',
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const TelaPratoPrincipal(), // base da pilha de navegação
    );
  }
}
