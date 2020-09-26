class Note{
  String noteId, noteTitle, noteContent;
  DateTime dateCreated, lastEdited;

    Note({
      this.noteId, this.noteTitle, this.noteContent, this.dateCreated, this.lastEdited,
    });

    factory Note.fromJson(Map<String, dynamic> item){
      return Note(
        noteId: item['noteID'],
        noteContent: item['noteContent'],
        noteTitle: item['noteTitle'],
        dateCreated: DateTime.parse(item['createDateTime']),
        lastEdited: item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null
          
      );
    }
}