import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({
    @required this.linha,
    @required this.coluna,
  });

  /// Chamado pelo construtor de [Tabuleiro] no início ou
  /// reinício do jogo.
  void adicionarVizinho(Campo vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    /// Recursivamente chama o método [abrir] nos vizinhos
    /// até que pelo menos um deles contenha uma mina.
    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  /// Chamado por [Tabuleiro] ao fim do jogo.
  void revelarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  /// Retorna [true] se o campo estiver resolvido, ou seja,
  /// se contiver uma mina e estiver marcado com bandeira,
  /// ou se não contiver uma mina e estiver aberto. Se o
  /// campo ainda não estiver resolvido, retorna false.
  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }

  /// Retorna [true] se nenhum dos vizinhos contiver uma mina.
  /// Senão, retorna [false].
  bool get vizinhancaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  /// Usa o filtro [where] para retornar a quantidade de
  /// vizinhos que contêm uma mina.
  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((v) => v.minado).length;
  }
}
