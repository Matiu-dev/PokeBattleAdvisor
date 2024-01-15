import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static const String _keyData = 'myData';

  Future<bool> saveData(String data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString(_keyData, data);
      print('Data saved to SharedPreferences.');
      return true;
    } catch (e) {
      print('Error saving data to SharedPreferences: $e');
      return false;
    }
  }

  Future<String?> getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_keyData);

      return data;
    } catch (e) {
      print('Error retrieving data from SharedPreferences: $e');
      return null;
    }
  }
}