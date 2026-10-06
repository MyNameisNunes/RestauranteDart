String formatarValor(double valor) {
  // 12.5 -> "R$ 12,50"  (\$ escapa o cifrão, que no Dart inicia interpolação)
  return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
}