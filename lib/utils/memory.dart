import 'package:shared_preferences/shared_preferences.dart';

class Memory {

  // save note
  Future saveNote(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('note', val);

    return true;
  }

  // gets note content
  Future<String> getNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('note').toString();
  }

  // check if the app is running first time
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.get('isFirstTime') != true) {
      await prefs.setBool('isFirstTime', true);
      await saveNote(''); // save empty note

      return false;
    } else return true;
  }

}