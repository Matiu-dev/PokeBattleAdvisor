import 'dart:convert';

import 'Pokemon.dart';
import 'package:http/http.dart' as http;

class DownloadJson {
  Future<List<Pokemon>> fetchPokemonData() async {
    final response = await http.get(Uri.https('matiu-dev.github.io', '/pokeBattleJson.json'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> myPokemonsJson = jsonData['my_pokemons'];
      final List<dynamic> enemyPokemonsJson = jsonData['enemy_pokemons'];

      List<Pokemon> pokemonList = [];

      pokemonList.addAll(myPokemonsJson.map((pokemonJson) {
        return Pokemon.fromJson(pokemonJson);
      }));

      pokemonList.addAll(enemyPokemonsJson.map((pokemonJson) {
        return Pokemon.fromJson(pokemonJson);
      }));

      return pokemonList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
