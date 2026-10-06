import 'package:flutter/material.dart';
import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_bebida.dart';

// Cardápio definido no próprio código (requisito). "_" = privado ao arquivo
const _pratos = [
  ItemCardapio('Filé à parmegiana', 42.90),
  ItemCardapio('Frango grelhado', 34.50),
  ItemCardapio('Lasanha à bolonhesa', 38.00),
];

class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  ItemCardapio? pratoSelecionado; // null = nada escolhido ainda

  void avancar() {
    final prato = pratoSelecionado; // cópia local: o Dart garante que não é null
    if (prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(prato: prato)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Prato principal')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final prato in _pratos)
                  ListTile(
                    leading: Icon(prato == pratoSelecionado
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    title: Text(prato.nome),
                    trailing: Text(formatarValor(prato.valor)),
                    selected: prato == pratoSelecionado, // destaca com a cor do tema
                    onTap: () => setState(() => pratoSelecionado = prato),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // null desabilita o botão -> só avança com seleção
                onPressed: pratoSelecionado == null ? null : avancar,
                child: const Text('Avançar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}