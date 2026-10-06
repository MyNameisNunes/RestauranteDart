import 'package:flutter/material.dart';
import '../models/item_cardapio.dart';
import 'tela_finalizacao.dart';

// Fora da classe: const de topo de arquivo é permitido
const _formasPagamento = ['Pix', 'Cartão de crédito', 'Cartão de débito', 'Dinheiro'];

class TelaPagamento extends StatefulWidget {
  // Dados recebidos da tela anterior (imutáveis)
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;

  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  String? formaSelecionada; // o que muda fica no State

  void finalizar() {
    final forma = formaSelecionada;
    if (forma == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pagamento via $forma confirmado!')), // sem const
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato, // widget. = dados do construtor
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          formaPagamento: forma,
        ),
      ),
      (rota) => false, // limpa a pilha: finalização sem volta
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Pagamento')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final forma in _formasPagamento)
                  ListTile(
                    leading: Icon(forma == formaSelecionada
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked),
                    title: Text(forma),
                    selected: forma == formaSelecionada,
                    onTap: () => setState(() => formaSelecionada = forma),
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
                    onPressed: formaSelecionada == null ? null : finalizar,
                    child: const Text('Finalizar pedido'),
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