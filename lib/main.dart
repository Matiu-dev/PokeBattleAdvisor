import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'quiz/Pokemon.dart';
import 'quiz/QuizHomePage.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Pokemon App',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const MyHomePage(title: 'Pokemon List'),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizHomePage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Future<List<Pokemon>> _pokemonData;
//
//   Future<List<Pokemon>> _fetchPokemonData() async {
//     final response = await http.get(Uri.https('matiu-dev.github.io', '/pokeBattleJson.json'));
//
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       final List<dynamic> myPokemonsJson = jsonData['my_pokemons'];
//       final List<dynamic> enemyPokemonsJson = jsonData['enemy_pokemons'];
//
//       List<Pokemon> pokemonList = [];
//
//       pokemonList.addAll(myPokemonsJson.map((pokemonJson) {
//         return Pokemon(
//           id: pokemonJson['id'],
//           name: pokemonJson['name'],
//           type: List<String>.from(pokemonJson['type']),
//           moves: Map<String, dynamic>.from(pokemonJson['moves']),
//           picture: pokemonJson['picture'],
//         );
//       }).toList(),
//       );
//
//       pokemonList.addAll(enemyPokemonsJson.map((pokemonJson) {
//         return Pokemon(
//           id: pokemonJson['id'],
//           name: pokemonJson['name'],
//           type: List<String>.from(pokemonJson['type']),
//           moves: Map<String, dynamic>.from(pokemonJson['moves']),
//           picture: pokemonJson['picture'],
//         );
//       }).toList(),
//       );
//
//       return pokemonList;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _pokemonData = _fetchPokemonData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: FutureBuilder<List<Pokemon>>(
//           future: _pokemonData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               final List<Pokemon>? pokemonList = snapshot.data;
//
//               if (pokemonList != null && pokemonList.isNotEmpty) {
//                 return ListView.builder(
//                   itemCount: pokemonList.length,
//                   itemBuilder: (context, index) {
//                     final Pokemon pokemon = pokemonList[index];
//                     return ListTile(
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             pokemon.name,
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             'Types: ${pokemon.type.join(", ")}',
//                           ),
//                           Text(
//                             'Moves',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: pokemon.moves.entries.map((moveEntry) {
//                               final String moveName = moveEntry.key;
//                               final Map<String, dynamic> moveDetails = moveEntry.value;
//
//                               List<Widget> detailsWidgets = [];
//
//                               moveDetails.forEach((key, value) {
//                                 detailsWidgets.add(
//                                   Text('$key: $value'),
//                                 );
//                               });
//
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(moveName,
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: detailsWidgets,
//                                   ),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                           pokemon.picture != null ? Image.network(
//                             pokemon.picture,
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                           ) : SizedBox(),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return Text('No data available');
//               }
//             }
//           },
//         ),
//       ),
//     );
//   }
// }