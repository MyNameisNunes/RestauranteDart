import 'package:flutter/material.dart';
import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

// Cardápio definido no próprio código (requisito). "_" = privado ao arquivo
const _bebidas = [
  ItemCardapio('Suco natural', 8.90),
  ItemCardapio('Refrigerante lata', 6.50),
  ItemCardapio('Água mineral', 4.00),
];

class TelaBebida extends StatefulWidget {
  // Dado recebido da tela anterior (imutável)
  final ItemCardapio prato;

  const TelaBebida({super.key, required this.prato});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  ItemCardapio? bebidaSelecionada; // null = nada escolhido ainda

  void avancar() {
    final bebida = bebidaSelecionada;
    if (bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaSobremesa(
          prato: widget.prato, // widget. = dados do construtor
          bebida: bebida,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2. Bebida')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final bebida in _bebidas)
                  ListTile(
                    leading: Icon(bebida == bebidaSelecionada
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    title: Text(bebida.nome),
                    trailing: Text(formatarValor(bebida.valor)),
                    selected: bebida == bebidaSelecionada,
                    onTap: () => setState(() => bebidaSelecionada = bebida),
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
                    onPressed: bebidaSelecionada == null ? null : avancar,
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
