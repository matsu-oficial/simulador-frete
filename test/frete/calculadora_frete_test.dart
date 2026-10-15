import 'package:flutter_test/flutter_test.dart';
import 'package:simulador_frete/frete/calculadora_frete.dart';
import 'package:simulador_frete/model/tipo_frete.dart';

void main() {
  late CalculadoraFrete calculadora;

  setUp(() {
    calculadora = CalculadoraFrete();
  });

  group('CalculadoraFrete', () {
    test('deve calcular frete econômico', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
      );

      expect(resultado.valor, closeTo(22.0, 0.01));
      expect(resultado.prazoDias, 5);
    });

    test('deve calcular frete expresso', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.expresso,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
      );

      expect(resultado.valor, closeTo(48.0, 0.01));
      expect(resultado.prazoDias, 2);
    });

    test('retirada deve ser gratuita', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.retirada,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
      );

      expect(resultado.valor, closeTo(0.0, 0.01));
    });

    test('compra de 300 deve possuir frete grátis', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 300.0,
      );

      expect(resultado.valor, closeTo(0.0, 0.01));
    });

    test('FRETEGRATIS deve zerar o frete', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
        cupom: 'FRETEGRATIS',
      );

      expect(resultado.valor, closeTo(0.0, 0.01));
    });

    test('FRETE50 deve aplicar 50% de desconto', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
        cupom: 'FRETE50',
      );

      expect(resultado.valor, closeTo(11.0, 0.01));
    });

    test('cupom inválido não deve alterar o valor', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 100.0,
        cupom: 'ABC123',
      );

      expect(resultado.valor, closeTo(22.0, 0.01));
    });

    test('frete grátis por compra deve ter prioridade sobre cupom', () {
      final resultado = calculadora.calcular(
        tipo: TipoFrete.economico,
        peso: 2.0,
        distanciaKm: 100.0,
        valorCompra: 350.0,
        cupom: 'FRETE50',
      );

      expect(resultado.valor, closeTo(0.0, 0.01));
    });
  });
}
