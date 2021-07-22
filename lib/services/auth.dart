import 'package:just_note/models/the_user.dart';
import 'package:just_note/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  TheUser? _theUser(dynamic user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  // auth change stream
  Stream<TheUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _theUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential r = await _auth.signInAnonymously();
      User? user = r.user;
      return _theUser(user);
    } catch(e) {
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).createEmptyUserRecord();

      return _theUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _theUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}


