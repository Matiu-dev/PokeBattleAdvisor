import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/Question.dart';
import 'model/Pokemon.dart';
import 'download/DownloadJson.dart';

import 'package:cached_network_image/cached_network_image.dart';

class QuizPage extends StatefulWidget {

  final List<Pokemon> pokemonList;

  QuizPage(this.pokemonList);

  @override
  _QuizPageState createState() => _QuizPageState(pokemonList);
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _score = 0;
  late List<Question> _questions;
  late Timer _timer;
  int _timeLeft = 0;

  _QuizPageState(List<Pokemon> pokemonList) {
    _fetchAndSetQuestions(pokemonList);
  }

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    _timeLeft = _questions[_questionIndex].timeForQuestion;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _answerQuestion(-1); // -1 oznacza, że czas minął
        }
      });
    });
  }

  Future<void> _fetchAndSetQuestions(pokemonList) async {

    try {
      _questions = _generateQuestions(pokemonList);
      _startTimer();
      setState(() {
        // _startTimer();
      });
    } catch (e) {
      print('Wystąpił błąd: $e');
    }
  }

  List<Question> _generateQuestions(List<Pokemon> pokemonList) {

    List<Question> questions = [
      Question(
        questionText: 'W przypadku wystawienia do walki ${pokemonList[0].name},'
            'przeciwko ${pokemonList[4].name}. Jaką umiejętnościa offensywną powinieneś atakować?',
        questionImage: pokemonList[4].picture,
        options: pokemonList[0].moves.values.map((move) => move.name).toList(),
        correctOptionIndex: 2,
        timeForQuestion: 10,
      ),
      Question(
        questionText: 'Przeciwnik chce wybrać ${pokemonList[5].name}, '
            'jaki pokemon najlepiej się sprawdzi w walce z nim?',
        questionImage: pokemonList[5].picture,
        options: pokemonList.sublist(0, 4).map((pokemon) => pokemon.name).toList(),
        correctOptionIndex: 1, // pikachu
        timeForQuestion: 8,
      ),
      Question(
        questionText: 'Jakie typy ataków będą najbardziej skuteczne przeciwko ${pokemonList[6].name},'
            'który jest typu ${pokemonList[6].type}?',
        questionImage: pokemonList[6].picture,
        options: ["GHOST", "FIGHTING", "FIRE", "PSYCHIC"],
        correctOptionIndex: 0,//mankey
        timeForQuestion: 6,
      ),
      Question(
        questionText: 'Przeciwnik chce wybrać ${pokemonList[7].name}, '
            'jaki pokemon najlepiej się sprawdzi w walce z nim?',
        questionImage: pokemonList[7].picture,
        options: pokemonList.sublist(0, 4).map((pokemon) => pokemon.name).toList(),
        correctOptionIndex: 3,//mankey
        timeForQuestion: 4,
      ),
    ];
    return questions;
  }
  //odczytywanie

  void _answerQuestion(int selectedIndex) {
    _timer.cancel();

    if (selectedIndex == _questions[_questionIndex].correctOptionIndex) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _timeLeft = 0;
      _questionIndex++;
      if (_questionIndex < _questions.length) {
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: _questionIndex < _questions.length
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image.network(
            // _questions[_questionIndex].questionImage,
          CachedNetworkImage(
              key: UniqueKey(),
              imageUrl: _questions[_questionIndex].questionImage,
                width: 100,
                height: 200,
                fit: BoxFit.fill
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _questions[_questionIndex].questionText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          ..._questions[_questionIndex].options.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  _answerQuestion(entry.key);
                },
                child: Text(entry.value),
              ),
            );
          }).toList(),
          Text(
            'Pozostały czas: $_timeLeft s',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Koniec quizu!',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'Twój wynik to: $_score/${_questions.length}',
              style: TextStyle(fontSize: 18.0),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _questionIndex = 0;
                  _score = 0;
                });
              },
              child: Text('Rozpocznij ponownie'),
            ),
          ],
        ),
      ),
    );
  }
}