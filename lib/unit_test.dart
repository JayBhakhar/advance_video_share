import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  void initState() {
    super.initState();
  }


  UploadTask task;
  File file;
  String fileName = '';

  Future _selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false // for select only one
            );
    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path);
      fileName = result.files.single.name;
    });
  }

  Future _uploadFile() async {
    if (file == null) return;
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print(urlDownload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('unit Test'),
                ),
                TextButton(
                  onPressed: _selectFile,
                  child: Text('select file'),
                ),
                Text(file != null ? fileName : "no File selected"),
                TextButton(
                  onPressed: _uploadFile,
                  child: Text('upload file'),
                ),
                task != null ? buildUploadStatus(task) : Container(),
                Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/advance-video-share.appspot.com/o/files%2FIMG-20210731-WA0003.jpg?alt=media&token=6ab65bec-1e46-4071-b8d4-c62f650879c8"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progess = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progess * 100).toStringAsFixed(2);
            return Text('$percentage %');
          } else {
            return Container();
          }
        },
      );
}

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
