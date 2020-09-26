
import 'dart:convert';

import 'package:flutter_check_app/models/api_response.dart';
import 'package:flutter_check_app/models/note.dart';
import 'package:flutter_check_app/models/note_listing_model.dart';
import 'package:flutter_check_app/models/note_modification.dart';
import 'package:http/http.dart' as http;
 const String api = "http://www.api.notes.programmingaddict.com";






Future<ApiResponse> createGetRequest(data, url) async{
  const headers ={
    'apiKey': '9c8062b3-ba9f-4f67-a196-9b3525ee644c'
  };
  try{
    final result = await http.get(api + url, headers: headers);
  if(result.statusCode == 200){
    final jsonData = json.decode(result.body);

    final notes = <NoteListingModel>[];

    for(var item in jsonData){
      notes.add(NoteListingModel.fromJson(item));
    }

    return ApiResponse(data: notes);


  }
  return ApiResponse(error: true, message: "No record found");

  } catch(e){
    return ApiResponse(error: true, message: "A catch error occured");
  } 
}

  // If T is a List, K is the subtype of the list.
T fromJson<T, K>(dynamic json) {
  
  if (json is Iterable) {
    return _fromJsonList<K>(json) as T;
  } else if (T == Note) {
    return Note.fromJson(json) as T;
  } else if (T == NoteListingModel) {
    return NoteListingModel.fromJson(json) as T;
  }else if(T == dynamic){
    return NoteListingModel.fromJson(json) as T;
  } 
  else {
    throw Exception("Unknown class");
  }
}

List<K> _fromJsonList<K>(List jsonList) {
  if (jsonList == null) {
    return null;
  }
  final output = <K>[];

   for(var item in jsonList){
     output.add(fromJson(item));

   }
  return output;
}

 Future<T> createHttpGetRequest<T, K>(url) async {
   print("entered");
   const headers ={
      'apiKey': '9c8062b3-ba9f-4f67-a196-9b3525ee644c'
    };

  try{
    final result = await http.get(api + url, headers: headers);
    if(result.statusCode == 200){
      return fromJson<T, K>(json.decode(result.body));
    }
    return fromJson<T, K>(ApiResponse(error: true, message: "Could not fetch record"));
    // return ApiResponse<List<NoteListingModel>>(error: true, message: "An error occured");
  }catch(e){
    return fromJson<T, K>(ApiResponse(error: true, message: "A catch error occured"));
    // return ApiResponse(error: true, message: "A catch error occured");
  } 
 }

 Future<bool> createHttpModificationRequest<T, K>({url, NoteModification note, method}) async{
   const headers = {
     'apiKey': '9c8062b3-ba9f-4f67-a196-9b3525ee644c',
     'Content-Type': 'application/json'
   };

   try{
     var result;
     if(method == "post"){
        result = await http.post(api+ url, headers: headers, body: json.encode(note) );
     }else if(method == "put"){
        result = await http.put(api+ url, headers: headers, body: json.encode(note) );
     }else if(method == "delete"){
       result = await http.delete(api+ url, headers: headers );
     }
    if(result.statusCode == 201 || result.statusCode == 204){
      return true;
    }else{
      return false;
    }
   }catch(e){
     return false;
   }
 }

