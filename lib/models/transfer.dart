class Transfer {
  final double valor;
  final int numeroConta;

  Transfer(
    this.valor,
    this.numeroConta,
  );

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
