import 'package:flutter/material.dart';
import 'package:state_managment/models/notes_model.dart';

class NotesProvider with ChangeNotifier {
  List<NotesModel> notes = [];
  String query = "";
  bool searching = false;
  bool disposed = false;
  final TextEditingController searchcontroller = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  List<NotesModel> filterdNotes() {
    if (query.isEmpty) return notes;
    return notes
        .where((n) => n.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void addNotes(NotesModel note) {
    notes.add(note);
    notifyListeners();
  }

  void delete(String id) {
    notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void edit(String id, String title, String desc) {
    final index = notes.indexWhere((n) => n.id == id);
    if (index == -1) return;
    notes[index] = NotesModel(
      title: title,
      desc: desc,
      createdAt: notes[index].createdAt,
      id: id,
    );
  }

  void search(String value) {
    query = value;
    notifyListeners();
  }

  void openSearch() {
    searching = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!disposed) searchFocus.requestFocus();
    });
  }

  void closeSearch() {
    searchFocus.unfocus();
    searching = false;
    query = '';
    searchcontroller.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    disposed = true;
    searchcontroller.dispose();
    searchFocus.dispose();
    super.dispose();
  }
}
