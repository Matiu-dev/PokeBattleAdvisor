import 'Move.dart';

class Pokemon {
  final int id;
  final String name;
  final List<String> type;
  final Map<String, Move> moves;
  final String picture;

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.moves,
    required this.picture,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    Map<String, Move> movesMap = {};
    json['moves'].forEach((moveName, moveData) {
      movesMap[moveName] = Move(
        name: moveName,
        types: List<String>.from(moveData['type']),
      );
    });

    return Pokemon(
      id: json['id'],
      name: json['name'],
      type: List<String>.from(json['type']),
      moves: movesMap,
      picture: json['picture'],
    );
  }
}