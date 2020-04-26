
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'campo.dart';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.qtdeBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  void reiniciar() {
    _campos.forEach((c) => c.reiniciar());
    _sortearMinas();
  }

  void revelarBombas() {
    _campos.forEach((c) => c.revelarBomba());
  }

  void _criarCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _campos.add(Campo(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    /// Impede que a quantidade de bombas seja maior que a
    /// quantidade de campos no tabuleiro, assim evitando
    /// um loop infinito neste método [_sortearMinas].
    if (qtdeBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdeBombas) {
      int i = Random().nextInt(_campos.length);

      if (!_campos[i].minado) {
        sorteadas++;
        _campos[i].minar();
      }
    }
  }

  List<Campo> get campos {
    return _campos;
  }

  /// Retorna [true] se todos os campos do tabuleiros estiverem
  /// resolvidos. Um campo está resolvido quando:
  /// a) Se contém uma mina e está marcado com uma bandeira;
  /// b) Se não contém uma mina e está aberto.
  /// Se pelo menos um campo no tabuleiro não estiver resolvido,
  /// retorna [false].
  bool get resolvido {
    return _campos.every((c) => c.resolvido);
  }
}