// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:flutter_application/Showlist/shows_dart_page.dart';
import 'package:flutter_application/Showlist/shows_list_page.dart';

class NavigasiShow extends StatefulWidget {
  const NavigasiShow({super.key});

  @override
  State<NavigasiShow> createState() => _NavigasiShowState();
}

class _NavigasiShowState extends State<NavigasiShow> {
  bool _isFirstPage = true;

  void _togglePage() {
    setState(() {
      _isFirstPage = !_isFirstPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shows"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: _isFirstPage
                ? const Icon(Icons.list)
                : const Icon(Icons.widgets),
            onPressed: _togglePage,
          ),
        ],
      ),
      body: _isFirstPage ? const FlimdartPageShow() : const FlimListPageShows(),
    );
  }
}
