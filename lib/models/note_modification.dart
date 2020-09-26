class NoteModification{
  String noteTitle, noteContent;

  NoteModification({this.noteTitle, this.noteContent});

  factory NoteModification.fromJson(Map<String, dynamic> item){
    return NoteModification(
      noteTitle: item["noteTitle"],
      noteContent: item["noteContent"]
    );
  }

  Map<String, dynamic> toJson() =>{
    'noteTitle': noteTitle,
    'noteContent': noteContent
  };

  
}