import 'dart:math';
import 'package:flutter/material.dart';
 
void main() {
  runApp(MaterialApp(
    home: SelectDifficultyPage(),
  ));
}
 
class SelectDifficultyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione a Dificuldade'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuessNumberGame(difficulty: Difficulty.easy)),
                );
              },
              child: Text('Fácil (1 - 100)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuessNumberGame(difficulty: Difficulty.medium)),
                );
              },
              child: Text('Médio (1 - 500)'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuessNumberGame(difficulty: Difficulty.hard)),
                );
              },
              child: Text('Difícil (1 - 1000)'),
            ),
          ],
        ),
      ),
    );
  }
}
 
enum Difficulty {
  easy,
  medium,
  hard,
}
 
class GuessNumberGame extends StatefulWidget {
  final Difficulty difficulty;
  GuessNumberGame({required this.difficulty});
 
  @override
  _GuessNumberGameState createState() => _GuessNumberGameState();
}
 
class _GuessNumberGameState extends State<GuessNumberGame> {
  late int _numeroAleatorio;
  late int _tentativas;
  late int _palpite;
  late String _feedback;
 
  @override
  void initState() {
    super.initState();
    _iniciarJogo();
  }
 
 void _iniciarJogo() {
  setState(() {
    Random random = Random();
    switch(widget.difficulty) {
      case Difficulty.easy:
        _numeroAleatorio = 100;
        break;
      case Difficulty.medium:
        _numeroAleatorio = 500;
        break;
      case Difficulty.hard:
        _numeroAleatorio = 1000;
        break;
    }
    _tentativas = 0;
    _palpite = 0;
    _feedback = 'Tente adivinhar o número entre 1 e $_numeroAleatorio';
  });
}
 
  void _adivinharNumero() {
    setState(() {
      _tentativas++;
      if (_palpite == _numeroAleatorio) {
        _feedback = 'Parabéns! Você acertou em $_tentativas tentativas.';
      } else if (_palpite < _numeroAleatorio) {
        _feedback = 'Tente um número maior.';
      } else {
        _feedback = 'Tente um número menor.';
      }
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Adivinhação'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _feedback,
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _palpite = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                hintText: 'Digite seu palpite',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _adivinharNumero,
              child: Text('Adivinhar'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _iniciarJogo,
              child: Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}