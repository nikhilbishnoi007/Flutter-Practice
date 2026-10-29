import 'package:flutter/material.dart';
import 'package:state_managment/models/notes_model.dart';

class NotesProvider with ChangeNotifier{
  List<NotesModel> notes=[];
  void addNotes(NotesModel note){
    notes.add(note);
    notifyListeners();
  }
  void delete(String title){
    notes.removeWhere((note)=>note.title==title);
    notifyListeners();
  }
}