// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CariPage extends StatefulWidget {
  const CariPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CariPageState createState() => _CariPageState();
}

class _CariPageState extends State<CariPage> {
  List listData = [];
  final TextEditingController _searchController = TextEditingController();
  bool isListView = true;

  @override
  void initState() {
    super.initState();
  }

  void getData(String query) async {
    EasyLoading.show(status: 'loading...');

    // Menambahkan query parameters ke URL
    var url = Uri.parse("https://movies-api14.p.rapidapi.com/search")
        .replace(queryParameters: {'query': query});

    Map<String, String> headers = {
      'X-RapidAPI-Key': '918757a674msh280fd191ff5b4e9p1122e8jsnba69d31ccd16',
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com',
    };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson['contents'] != null) {
          setState(() {
            listData = responseJson['contents'];
          });
        } else {
          // Handle the case when the 'contents' key is null
        }
      } else {
        // Tangani kasus jika response tidak berhasil (misalnya, response.statusCode bukan 200)
      }
    } catch (error) {
      // Tangani kesalahan selama permintaan http
      print('Error: $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _onSubmitted(String value) {
    // Panggil getData dengan nilai dari TextField
    getData(value);
  }

  void toggleView() {
    setState(() {
      isListView = !isListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Search...",
          ),
          onSubmitted: _onSubmitted,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Panggil getData dengan nilai dari TextField
              _onSubmitted(_searchController.text);
            },
          ),
          IconButton(
            icon: isListView
                ? const Icon(Icons.grid_view)
                : const Icon(Icons.list),
            onPressed: toggleView,
          ),
        ],
      ),
      body: isListView
          ? NewWidgetList(listData: listData)
          : NewWidgetGrid(listData: listData),
    );
  }
}

class NewWidgetList extends StatelessWidget {
  const NewWidgetList({
    super.key,
    required this.listData,
  });

  final List listData;

  @override
  Widget build(BuildContext context) {
    if (listData.isNotEmpty) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 1,
          ),
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: listData.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Warna bayangan
                        spreadRadius: 1, // Seberapa jauh bayangan menyebar
                        blurRadius: 3, // Seberapa kabur bayangan
                        offset: const Offset(
                            0, 3), // Posisi bayangan (horizontal, vertical)
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/flim-detailCari',
                          arguments: listData[index]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      backgroundImage: listData[index]['poster_path'] != null
                          ? NetworkImage(
                              listData[index]['poster_path'] as String)
                          : null, // Set it to null when using a user icon
                      child: listData[index]['poster_path'] == null
                          ? const Icon(Icons.person,
                              color: Colors.white) // User icon
                          : null,
                      // Replace this with a placeholder image
                    ),
                    title: Text(listData[index]['title'] ?? 'No title'),
                    subtitle: Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      "Release Date: " +
                          (listData[index]['release_date'] ?? 'Unknown'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 300.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 0, 0, 1)),
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                          'Enabling users to search for movies and TV shows '),
                      TyperAnimatedText('Shows based on specific criteria,'),
                      TyperAnimatedText(
                          'Such as genre, actor, director, or keyword'),
                      TyperAnimatedText(
                          'Provides a personalized and efficient content discovery experience.'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                    totalRepeatCount: 50,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  const Divider(
                    thickness: 2,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class NewWidgetGrid extends StatelessWidget {
  const NewWidgetGrid({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List listData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.7,
      ),
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int index) {
        return buildGridItem(context, index);
      },
    );
  }

  Widget buildGridItem(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/flim-detailCari',
              arguments: listData[index]);
        },
        child: Stack(fit: StackFit.expand, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 270, // Adjust the height as needed
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: listData[index]['poster_path'] != null
                        ? NetworkImage(listData[index]['poster_path'] as String)
                        : const AssetImage('path_to_placeholder_image')
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Text(
                listData[index]['title'] ?? 'No title',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
