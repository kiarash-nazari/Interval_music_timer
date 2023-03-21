import 'package:shared_preferences/shared_preferences.dart';

class SaveData {

  Future<void> saveData(int percent, String id) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(id, percent);
  }
}
