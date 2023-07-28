import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void saveLocal(String key, value) async {
    final prefer = await SharedPreferences.getInstance();
    prefer.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final prefer = await SharedPreferences.getInstance();
    if (prefer.getString(key) == null)
      return;
    else
      return json.decode(prefer.getString(key)!);
  }

  Future<bool> contains(String key) async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefer = await SharedPreferences.getInstance();
    return prefer.remove(key);
  }
  //cerrar seccion

// void logOutPreference(BuildContext context, String ? idUser)async{
//     UserProvider provider= new UserProvider();
//     provider.init(context);
//     await provider.logout(idUser!);
//     await remove('user');
//     Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
// }
}
