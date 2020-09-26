class NoteListingModel{
    String noteId, noteTitle;
    DateTime dateCreated, lastEdited;

    NoteListingModel({
      this.noteId, this.noteTitle, this.dateCreated, this.lastEdited,
    });

    factory NoteListingModel.fromJson(Map<String, dynamic> item){
      return NoteListingModel(
        noteId: item['noteID'],
        noteTitle: item['noteTitle'],
        dateCreated: DateTime.parse(item['createDateTime']),
        lastEdited: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null
          
      );
    }


}

// List<NoteListingModel> myNotes = [
//   NoteListingModel(noteId: "1", noteTitle: "A new way to live", dateCreated: DateTime.now(), lastEdited: DateTime.now()),
//   NoteListingModel(noteId: "2", noteTitle: "Note 2", dateCreated: DateTime.now(), lastEdited: DateTime.now(),),
//   NoteListingModel(noteId: "3", noteTitle: "Note 3", dateCreated: DateTime.now(), lastEdited: DateTime.now(),),
//   NoteListingModel(noteId: "4", noteTitle: "Note 4", dateCreated: DateTime.now(), lastEdited: DateTime.now(),),
//   NoteListingModel(noteId: "5", noteTitle: "Note 5", dateCreated: DateTime.now(), lastEdited: DateTime.now(),),
// ];