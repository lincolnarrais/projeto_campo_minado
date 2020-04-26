import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';

class CampoMinadoApp extends StatelessWidget {
  _reiniciar() {
    print('reiniciar...');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: null,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          child: Text('Tabuleiro'),
        ),
      ),
    );
  }
}
