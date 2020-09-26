import 'package:flutter/material.dart';
import 'package:flutter_check_app/services/note_service.dart';
import 'package:flutter_check_app/views/button_widget.dart';
import 'package:flutter_check_app/views/note_list.dart';
import 'package:get_it/get_it.dart';


void setupLocator(){
  GetIt.I.registerLazySingleton(() => NotesService());
}
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: NoteList(),
      home: ButtonWidget(),
    );
  }
}

