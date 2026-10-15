import '../cupom/catalogo_cupons.dart';
import '../model/resultado_frete.dart';
import '../model/tipo_frete.dart';
import 'strategy/frete_economico.dart';
import 'strategy/frete_expresso.dart';
import 'strategy/frete_strategy.dart';
import 'strategy/retirada_loja.dart';

class CalculadoraFrete {
  ResultadoFrete calcular({
    required TipoFrete tipo,
    required double peso,
    required double distanciaKm,
    required double valorCompra,
    String cupom = '',
  }) {
    final FreteStrategy strategy = switch (tipo) {
      TipoFrete.economico => FreteEconomico(),
      TipoFrete.expresso => FreteExpresso(),
      TipoFrete.retirada => RetiradaLoja(),
    };

    final resultado = strategy.calcular(
      peso: peso,
      distanciaKm: distanciaKm,
    );

    // Regra de maior prioridade.
    if (valorCompra >= 300.0) {
      return resultado.copyWith(valor: 0.0);
    }

    final cupomEncontrado = CatalogoCupons.buscar(cupom);

    if (cupomEncontrado == null) {
      return resultado;
    }

    final valorComDesconto = cupomEncontrado.aplicar(
      resultado.valor,
    );

    return resultado.copyWith(
      valor: valorComDesconto,
    );
  }
}
