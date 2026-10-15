class CupomFrete {
  final String codigo;
  final double percentualDesconto;

  const CupomFrete({
    required this.codigo,
    required this.percentualDesconto,
  });

  double aplicar(double valorFrete) {
    return valorFrete * (1 - percentualDesconto);
  }
}
