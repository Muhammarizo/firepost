import 'package:shared_preferences/shared_preferences.dart';
// bir dona String tipidagi malumotni saqlash olish va uchirib tashlash
// nmaga bitta string malumot dgan savolga jovob. firebase da login qganda user_id dgan narsa boladi uwa buyica tanivoliw ucun
class Prefs {
  static Future<bool> saveUserId(String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('user_id', user_id);
  }

  static Future<String?> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_id');
    return token;
  }

  static Future<bool> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('user_id');
  }
}
