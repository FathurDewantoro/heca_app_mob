import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  Future<void> saveIdUser(String idUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('idUser', idUser);
  }

  Future<String?> readIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('idUser');
  }

  Future<void> deleteIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('idUser');
  }

  Future<bool> checkLogin() async {
    var id = await readIdUser();
    if (id != null) {
      return true;
    } else {
      return false;
    }
  }
}
