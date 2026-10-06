import 'package:flutter/material.dart';
import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_pagamento.dart';

// Cardápio definido no próprio código (requisito). "_" = privado ao arquivo
const _sobremesas = [
  ItemCardapio('Pudim', 9.90),
  ItemCardapio('Petit gâteau', 16.90),
  ItemCardapio('Salada de frutas', 8.50),
];

class TelaSobremesa extends StatefulWidget {
  // Dados recebidos das telas anteriores (imutáveis)
  final ItemCardapio prato;
  final ItemCardapio bebida;

  const TelaSobremesa({
    super.key,
    required this.prato,
    required this.bebida,
  });

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  ItemCardapio? sobremesaSelecionada; // null = nada escolhido ainda

  void avancar() {
    final sobremesa = sobremesaSelecionada;
    if (sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato, // widget. = dados do construtor
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Sobremesa')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final sobremesa in _sobremesas)
                  ListTile(
                    leading: Icon(sobremesa == sobremesaSelecionada
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    title: Text(sobremesa.nome),
                    trailing: Text(formatarValor(sobremesa.valor)),
                    selected: sobremesa == sobremesaSelecionada,
                    onTap: () =>
                        setState(() => sobremesaSelecionada = sobremesa),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: sobremesaSelecionada == null ? null : avancar,
                    child: const Text('Avançar'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context), // volta 1 tela
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.popUntil(
                            context, (rota) => rota.isFirst), // volta ao prato
                        child: const Text('Voltar ao início'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
