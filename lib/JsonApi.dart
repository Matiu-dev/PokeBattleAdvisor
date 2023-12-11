import 'dart:async';
import 'package:http/http.dart' as http;

class JsonApi {
  static Future getJson() {
    return http.get("https://matiu-dev.github.io/pokeBattleJson.json" as Uri);
  }
}