import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QuizPage.dart';
import 'DownloadJson.dart';
import 'Pokemon.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class QuizHomePage extends StatelessWidget {

  late List<Pokemon> pokemonList;

  //tego nie ma w statelessWidget
  // @override
  // void initState() {
  //   _fetchAndSetQuestions();
  // }

  QuizHomePage() {
    _fetchAndSetQuestions();
  }

  Future<void> _fetchAndSetQuestions() async {
    final downloadJson = DownloadJson();
    try {
      pokemonList = await downloadJson.fetchPokemonData();
    } catch (e) {
      print('Wystąpił błąd: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizPage(pokemonList)),
            );
          },
          child: Text('Uruchom quiz'),
        ),
      ),
    );
  }
}