import 'cupom_frete.dart';

class CatalogoCupons {
  static const cupons = <String, CupomFrete>{
    'FRETEGRATIS': CupomFrete(
      codigo: 'FRETEGRATIS',
      percentualDesconto: 1.0,
    ),
    'FRETE50': CupomFrete(
      codigo: 'FRETE50',
      percentualDesconto: 0.50,
    ),
  };

  static CupomFrete? buscar(String codigo) {
    return cupons[codigo.trim().toUpperCase()];
  }
}
