import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:just_note/api/firebase_api.dart';
import 'package:just_note/services/database.dart';

class CreateImageScreen extends StatefulWidget {
  final DatabaseService databaseService;

  CreateImageScreen({required this.databaseService});

  @override
  _CreateImageScreenState createState() => _CreateImageScreenState();
}

class _CreateImageScreenState extends State<CreateImageScreen> {

  File? file;
  UploadTask? task;

  @override
  void initState() {
    super.initState();
    selectAndUploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child:  task != null ? buildUploadStatus(task!) : Container(),
        ),
      ),
    );
  }

  Future selectAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom, allowedExtensions: ['png', 'jpg', 'gif', 'tiff']);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));

    final String fileName = DateTime
        .now()
        .toUtc()
        .millisecondsSinceEpoch
        .toRadixString(32);
    final destination = 'notes/${widget.databaseService.uid}/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    await widget.databaseService.addNote(imageUrl: urlDownload);

    Navigator.of(context).pop();
  }

  Widget buildUploadStatus(UploadTask task) =>
      StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(0);

            return Text('$percentage%', style: TextStyle(fontSize: 46),);
          } else {
            return Container();
          }
        },
      );
}
