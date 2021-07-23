import 'package:just_note/models/note.dart';
import 'package:just_note/models/the_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future createEmptyUserRecord() async {
    return await usersCollection.doc(uid).set({
      'notes': []
    });
  }

  Future updateNotes(List newNotes) async {
    return await usersCollection.doc(uid).update({
      'notes': newNotes
    });
  }

  Future addNote({String title = '', String content = '', String? imageUrl}) async {
    return await usersCollection.doc(uid).update({
      'notes': FieldValue.arrayUnion([
        {
          'title': title,
          'content': content,
          'image': imageUrl
        }
      ])
    });
  }
  // usr data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid.toString(), notes: snapshot.get('notes'));
  }

  // get usr doc
  Stream<UserData> get userData {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}