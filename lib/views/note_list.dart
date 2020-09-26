import 'package:flutter/material.dart';
import 'package:flutter_check_app/models/api_response.dart';
import 'package:flutter_check_app/models/note_listing_model.dart';
import 'package:flutter_check_app/services/note_service.dart';
import 'package:flutter_check_app/views/note_modify.dart';
import 'package:flutter_check_app/widgets/note_delete.dart';
import 'package:get_it/get_it.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  ApiResponse<List<NoteListingModel>> _apiResponse;
  bool _isLoading = false;

  // List<NoteListingModel> notes = [];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  void navigateToPage(context, noteId) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (_) => NoteModify(
                  noteId: noteId,
                )))
        .then((_) => _fetchNotes());
  }

  @override
  void initState() {
    // notes = service.getNotesList();
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    // _apiResponse = await service.getNotesList();
    var data = await service.getAllNotesList();
    _apiResponse = ApiResponse(data: data);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          // getAllList();

          // var data = await service.getAllNotesList();
          navigateToPage(context, null);
          //  setState(() {
          //    _apiResponse = ApiResponse();
          //   _apiResponse = ApiResponse(data: data);
          // });
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchNotes(),
        child: Builder(
          builder: (context) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (_apiResponse.error) {
              return Center(
                child: Text(_apiResponse.message),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1.0, color: Colors.blueGrey),
              itemBuilder: (ctx, int i) {
                NoteListingModel note = _apiResponse.data[i];
                return Dismissible(
                  key: ValueKey(note.noteId),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    bool result = await showDialog(
                      context: context,
                      builder: (_) => NoteDelete(
                        title: "Warning!!",
                        message: "Are you sure you want to delete this note?",
                        hasActions: true,
                      ),
                    );
                    print(result);
                    if (result == true) {
                      bool isDeleted = await service.deleteNote(note.noteId);
                      if (isDeleted == true) { 
                        Navigator.pop(context);
                      }
                    }
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.delete, color: Colors.white)),
                  ),
                  child: ListTile(
                    title: Text(note.noteTitle),
                    subtitle: Text(
                        "Last editied on ${formatDateTime(note.lastEdited ?? note.dateCreated)}"),
                    onTap: () => navigateToPage(context, note.noteId),
                  ),
                );
              },
              itemCount: _apiResponse.data.length,
            );
          },
        ),
      ),
    );
  }
}
