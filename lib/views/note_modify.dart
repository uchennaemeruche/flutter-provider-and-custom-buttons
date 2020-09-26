import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_check_app/models/api_response.dart';
import 'package:flutter_check_app/models/note.dart';
import 'package:flutter_check_app/models/note_modification.dart';
import 'package:flutter_check_app/services/note_service.dart';
import 'package:flutter_check_app/widgets/animated_button.dart';
import 'package:get_it/get_it.dart';

class NoteModify extends StatefulWidget {
  NoteModify({Key key, this.noteId}) : super(key: key);

  final String noteId;

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  bool get isEditing => widget.noteId != null;

  NotesService get service => GetIt.I<NotesService>();
  
  String errorMessage;
  Note note;
  bool isLoading = false;



  @override
  void initState() {
    if(isEditing){
      service.getNote(widget.noteId).then((res){
        var response = ApiResponse(data: res);
      isLoading = true;
      if(response.error){
        errorMessage = response.message ?? "An error occured here";

      }
      note = response.data;
      _titleController.text = note.noteTitle;
      _contentController.text = note.noteContent;

      isLoading = false;
    });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${isEditing ? "Update Note" : "Create Note"}"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Note Tile"
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: "Note content"
              ),
            ),
            SizedBox(height: 10.0,),
            SizedBox(
              width: double.infinity,
                          child: RaisedButton(
                child: Text("Submit", style: TextStyle(color: Colors.white),),
                color: Theme.of(context).primaryColor,
                onPressed: ()async{
                  NoteModification note = NoteModification(
                    noteTitle: _titleController.text,
                    noteContent: _contentController.text
                  );
                  bool isDone;
                  if(isEditing){
                    isDone = await service.updateNote(widget.noteId, note);
                  }else{
                    isDone = await service.addNote(note);
                  }

                  
                  print("IS added is $isDone");
                  if(isDone == true){
                    
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            SizedBox(height: 20.0),
            
          ],
        ),
      ),
    );
  }
}

