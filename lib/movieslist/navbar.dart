import 'package:flutter/material.dart';

import 'package:flutter_application/movieslist/flim_dart_page.dart';
import 'package:flutter_application/movieslist/flim_list_page.dart';

class Navigasi extends StatefulWidget {
  const Navigasi({super.key});

  @override
  State<Navigasi> createState() => _NavigasiState();
}

class _NavigasiState extends State<Navigasi> {
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
        title: const Text("Movies"),
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
      body: _isFirstPage ? const FlimdartPage() : const FlimListPage(),
    );
  }
}
