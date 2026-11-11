import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_managment/providers/notes_provider.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle({super.key});
  @override
  Widget build(BuildContext context) {
    final isSearching = context.select<NotesProvider, bool>((p) => p.searching);
    final provider = context.read<NotesProvider>();
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: ((child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      )),
      child: isSearching
          ? TextField(
              key: const ValueKey("searchField"),
              controller: provider.searchcontroller,
              focusNode: provider.searchFocus,
              onChanged: provider.search,
              decoration: InputDecoration(
                hint: Text("Search title",style: TextStyle(fontSize: 16),),
                border: InputBorder.none,
              ),
            )
          : Align(
              key: ValueKey("title"),
              alignment: Alignment.center,
              child: Text("My Notes"),
            ),
    );
  }
}

class SearchAction extends StatelessWidget {
  const SearchAction({super.key});

  @override
  Widget build(BuildContext context) {
    final isSearching = context.select<NotesProvider, bool>((p) => p.searching);
    final provider = context.read<NotesProvider>();
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => RotationTransition(
        turns: Tween<double>(begin: 0.75, end: 1).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      ),
      child: isSearching
          ? IconButton(
              key: ValueKey('close'),
              onPressed: provider.closeSearch,
              icon: Icon(CupertinoIcons.clear),
            )
          : IconButton(
              key: ValueKey('search'),
              onPressed: provider.openSearch,
              icon: Icon(CupertinoIcons.search),
            ),
    );
  }
}
