import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  final String title, message;
  final bool hasActions;

  const NoteDelete({Key key, this.title, this.message, this.hasActions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: hasActions ? 
      [
        FlatButton(child: Text("Yes"), onPressed: () => Navigator.of(context).pop(true),),
        FlatButton(child: Text("No"), onPressed: () => Navigator.of(context).pop(false),),
      ] 
      : [FlatButton(child: Text("Ok"), onPressed: () => Navigator.of(context).pop(true),),],
    );
  }
}