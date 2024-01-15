import 'package:http/http.dart' as http;

import 'package:pokebattleadvisor/quiz/download/MySharedPreferences.dart';

class DownloadRemoteSource {
  final MySharedPreferences mySharedPreferences = MySharedPreferences();

  Future<String> fetchData() async {
    try {
      final response = await http.get(Uri.https('matiu-dev.github.io', '/pokeBattleJson.json'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load data');
      } else {
        final isSaved = await mySharedPreferences.saveData(response.body);
        if (isSaved) {
          return response.body;
        } else {
          throw Exception('Failed to save data');
        }
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}