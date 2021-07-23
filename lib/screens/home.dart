import 'package:flutter/material.dart';
import 'package:just_note/models/note.dart';
import 'package:just_note/models/the_user.dart';
import 'package:just_note/screens/create.dart';
import 'package:just_note/screens/create_image.dart';
import 'package:just_note/services/database.dart';
import 'package:just_note/widgets/more_options_sheet.dart';
import 'package:just_note/widgets/no_notes_info.dart';
import 'package:just_note/widgets/note_tile.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final UserData userData = Provider.of(context);
    final user = Provider.of<TheUser?>(context);
    final List<Note> notes = notesFromDB(userData.notes);

    DatabaseService databaseService = DatabaseService(uid: user!.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('inoNotes'),
        actions: [
          IconButton(onPressed: () {
            showModalBottomSheet(
                context: context, builder: (BuildContext context) {
              return MoreOptionsSheet();
            });
          }, icon: Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        closedForegroundColor: Colors.white,
        openForegroundColor: Theme.of(context).accentColor,
        closedBackgroundColor: Theme.of(context).accentColor,
        openBackgroundColor: Colors.white,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(Icons.create),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            label: 'Text note',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateScreen(databaseService: databaseService,)));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.image),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            label: 'Image',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateImageScreen(databaseService: databaseService,)));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: notes.isEmpty ? NoNotesInfo() : ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return NoteTile(note: notes[index], delete: () {
              userData.notes.removeAt(index);
              databaseService.updateNotes(userData.notes);
            });
          },
        ),
      ),
    );
  }
}