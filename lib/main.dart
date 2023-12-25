import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class Pokemon {
  final int id;
  final String name;
  final List<String> type;
  final Map<String, dynamic> moves;
  // final String picture;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.moves,
    // required this.picture,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pokemon List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Pokemon>> _pokemonData;

  Future<List<Pokemon>> _fetchPokemonData() async {
    final response = await http.get(Uri.https('matiu-dev.github.io', '/pokeBattleJson.json'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> myPokemonsJson = jsonData['my_pokemons'];

      List<Pokemon> pokemonList = myPokemonsJson.map((pokemonJson) {
        return Pokemon(
          id: pokemonJson['id'],
          name: pokemonJson['name'],
          type: List<String>.from(pokemonJson['type']),
          moves: Map<String, dynamic>.from(pokemonJson['moves']),
          // picture: pokemonJson['picture'],
        );
      }).toList();

      return pokemonList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _pokemonData = _fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: _pokemonData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<Pokemon>? pokemonList = snapshot.data;

              if (pokemonList != null && pokemonList.isNotEmpty) {
                return ListView.builder(
                  itemCount: pokemonList.length,
                  itemBuilder: (context, index) {
                    final Pokemon pokemon = pokemonList[index];
                    return ListTile(
                      // leading: Image.network(pokemon.picture),
                      title: Text(pokemon.name),
                      subtitle: Text('Type: ${pokemon.type.join(", ")}'),
                    );
                  },
                );
              } else {
                return Text('No data available');
              }
            }
          },
        ),
      ),
    );
  }
}