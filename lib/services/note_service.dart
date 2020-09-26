import 'dart:convert';

import 'package:flutter_check_app/models/api_response.dart';
import 'package:flutter_check_app/models/note.dart';
import 'package:flutter_check_app/models/note_listing_model.dart';
import 'package:flutter_check_app/models/note_modification.dart';
import 'package:flutter_check_app/services/http_helpers.dart';
import 'package:http/http.dart' as http;


class NotesService{

  static const String api = "http://www.api.notes.programmingaddict.com";
  static const headers ={
    'apiKey': '9c8062b3-ba9f-4f67-a196-9b3525ee644c'
  };


  Future<ApiResponse<List<NoteListingModel>>> getNotesList(){
    // return myNotes;
    return http.get(api + "/notes", headers: headers).then((data){
      if(data.statusCode == 200){
        // Covert response body to a list of maps
        final jsonData = json.decode(data.body);
        print("Json Data");
        // print(jsonData);
        final notes = <NoteListingModel>[];
        // Convert the list of map to a dart object;
        for(var item in jsonData){
          // print("item");
          // print(item);
          
          // final note = NoteListingModel(
          //   noteId: item['noteID'],
          //   noteTitle: item['noteID'],
  
          //   dateCreated: DateTime.parse(item['createDateTime']),
          //   lastEdited: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null
          // );
          // notes.add(note);

          notes.add(NoteListingModel.fromJson(item));
          
        }
        print("A new note");
        print(notes);
        
        return ApiResponse<List<NoteListingModel>>(data: notes);

      }
      return ApiResponse<List<NoteListingModel>>(error: true, message: "An error occured");
    }).catchError((_) => ApiResponse<List<NoteListingModel>>(error: true, message: "An error occured, please catch it" ));
  }


// Future<ApiResponse<List<NoteListingModel>>> getAllNotesList(){
//   // return createGetRequest("data", "/notes");
//   // return NetworkRequest.createHttpGetRequest<List<NoteListingModel>, NoteListingModel>();
//   return createHttpGetRequest<ApiResponse<List<NoteListingModel>>, ApiResponse<NoteListingModel> >();
// }

Future<List<NoteListingModel>> getAllNotesList(){
  // return createGetRequest("data", "/notes");
  // return NetworkRequest.createHttpGetRequest<List<NoteListingModel>, NoteListingModel>();
  return createHttpGetRequest<List<NoteListingModel>, NoteListingModel>("/notes");
}

Future<Note> getNote(noteId){
  final String url = "/notes/" + noteId;
 return createHttpGetRequest<Note, Null>(url);
}


Future<bool> addNote(NoteModification note){
  final String url = "/notes";
  return createHttpModificationRequest<bool, Null>(url:url, note: note, method:"post");
}

Future<bool> updateNote(noteId, NoteModification note){
  final String url = "/notes/" + noteId;
  return createHttpModificationRequest<bool, Null>(url:url, note:note, method:"put");
}

Future<bool> deleteNote(noteId){
  final String url = "/notes/" + noteId;
  return createHttpModificationRequest<bool, Null>(url:url, method: "delete");
}
//   getAllList(){
//   // return _getRequest(NoteListingModel);
//   return _getRequest<List<NoteListingModel>, NoteListingModel>();
//  }



  // Future<ApiResponse<Note>> getNote(noteId){
  //   return http.get(api + "/notes/" + noteId, headers: headers).then((data){
  //     if(data.statusCode == 200){
  //       // Convert returned data to a map
  //       final item = json.decode(data.body);
  //       final note = Note.fromJson(item);
  //       // final note = Note(
  //       //   noteId: item['noteID'],
  //       //   noteContent: item['noteContent'],
  //       //     noteTitle: item['noteID'],
  //       //     dateCreated: DateTime.parse(item['createDateTime']),
  //       //     lastEdited: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null
  //       // );

  //       return ApiResponse<Note>(data: note); 
  //     }
  //     return ApiResponse<Note>(error: true, message: "Please check status code");
  //   }).catchError((_) => ApiResponse<Note>(error:true, message: "Catch error occured"));
    
  // }


}


