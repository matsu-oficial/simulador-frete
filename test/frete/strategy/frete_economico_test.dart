import 'package:flutter_test/flutter_test.dart';
import 'package:simulador_frete/frete/strategy/frete_economico.dart';

void main() {
  late FreteEconomico strategy;

  setUp(() {
    strategy = FreteEconomico();
  });

  test('deve calcular frete considerando peso e distância', () {
    final resultado = strategy.calcular(
      peso: 2.0,
      distanciaKm: 100.0,
    );

    expect(resultado.valor, closeTo(22.0, 0.01));
  });
}
