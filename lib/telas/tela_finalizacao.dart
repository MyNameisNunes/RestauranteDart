import 'package:flutter/material.dart';
import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_prato_principal.dart';

class TelaFinalizacao extends StatelessWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String formaPagamento;

  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.formaPagamento,
  });

  void novoPedido(BuildContext context) {
    // o SnackBar do pagamento passaria para a tela 1 e cobriria o "Avançar"
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false, // pilha limpa: novo State, escolhas reiniciadas
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = prato.valor + bebida.valor + sobremesa.valor;
    const negrito = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: const Text('5. Finalização'),
        automaticallyImplyLeading: false, // sem seta de voltar
      ),
      body: PopScope(
        canPop: false, // bloqueia o voltar do Android e do navegador
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(prato.nome),
              subtitle: const Text('Prato principal'),
              trailing: Text(formatarValor(prato.valor)),
            ),
            ListTile(
              leading: const Icon(Icons.local_drink),
              title: Text(bebida.nome),
              subtitle: const Text('Bebida'),
              trailing: Text(formatarValor(bebida.valor)),
            ),
            ListTile(
              leading: const Icon(Icons.icecream),
              title: Text(sobremesa.nome),
              subtitle: const Text('Sobremesa'),
              trailing: Text(formatarValor(sobremesa.valor)),
            ),
            const Divider(),
            ListTile(
              title: const Text('Total', style: negrito),
              trailing: Text(formatarValor(total), style: negrito),
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Forma de pagamento'),
              trailing: Text(formaPagamento),
            ),
          ],
        ),
      ),
      // Fora do body: o Scaffold desenha o SnackBar do pagamento ACIMA daqui
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => novoPedido(context),
            child: const Text('Novo pedido'),
          ),
        ),
      ),
    );
  }
}
