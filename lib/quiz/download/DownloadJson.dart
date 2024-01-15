import 'dart:convert';

import 'package:pokebattleadvisor/quiz/download/MySharedPreferences.dart';
import 'package:pokebattleadvisor/quiz/download/DownloadRemoteSource.dart';

import '../model/Pokemon.dart';

class DownloadJson {

  final MySharedPreferences mySharedPreferences = MySharedPreferences();
  final DownloadRemoteSource downloadRemoteSource = DownloadRemoteSource();

  Future<List<Pokemon>> fetchPokemonData() async {
    try {
      final String? jsonData = await mySharedPreferences.getData();

      if(jsonData != null) {
        final List<dynamic> myPokemonsJson = jsonDecode(jsonData)['my_pokemons'];
        final List<dynamic> enemyPokemonsJson = jsonDecode(jsonData)['enemy_pokemons'];

        List<Pokemon> pokemonList = [];

        pokemonList.addAll(myPokemonsJson.map((pokemonJson) {
          return Pokemon.fromJson(pokemonJson);
        }));

        pokemonList.addAll(enemyPokemonsJson.map((pokemonJson) {
          return Pokemon.fromJson(pokemonJson);
        }));

        return pokemonList;
      } else {
        await downloadRemoteSource.fetchData();
        return fetchPokemonData();
      }
    } catch(error) {
      throw Exception(error);
    }

  }
}
