// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List listData = [];
  List listData1 = [];

  @override
  void initState() {
    super.initState();
    getData();
    getData1();
  }

  void getData() async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse("https://movies-api14.p.rapidapi.com/shows");
    Map<String, String> headers = {
      'X-RapidAPI-Key': '918757a674msh280fd191ff5b4e9p1122e8jsnba69d31ccd16',
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com'
    };
    var respon = await http.get(url, headers: headers);
    var responJson = jsonDecode(respon.body);

    setState(() {
      listData = responJson["movies"];
    });
    EasyLoading.dismiss();
  }

  void getData1() async {
    EasyLoading.show(status: 'loading...');
    var url = Uri.parse("https://movies-api14.p.rapidapi.com/movies");
    Map<String, String> headers = {
      'X-RapidAPI-Key': '918757a674msh280fd191ff5b4e9p1122e8jsnba69d31ccd16',
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com'
    };
    var respon = await http.get(url, headers: headers);
    var responJson = jsonDecode(respon.body);

    setState(() {
      listData1 = responJson["movies"];
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoviesL'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            shows_list(listData: listData),
            shows_list1(listData1: listData1),
          ],
        ),
      ),
    );
  }
}

class shows_list extends StatelessWidget {
  const shows_list({
    super.key,
    required this.listData,
  });

  final List listData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/nav-show',
            );
          },
          title: const Text(
            "TV Shows",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Set fontWeight to bold
            ),
          ),
          subtitle: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                  'Provides with an extensive selection of TV Shows '),
            ],
            onTap: () {},
            totalRepeatCount: 5,
            pause: const Duration(milliseconds: 2000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 35,
          ),
        ),
        Container(
          height: 230,

          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Warna bayangan
                spreadRadius: 1, // Seberapa jauh bayangan menyebar
                blurRadius: 1, // Seberapa kabur bayangan
                offset: const Offset(
                    0, 3), // Posisi bayangan (horizontal, vertical)
              ),
            ],
          ),
          // Adjust the height of the GridView as needed
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Number of Rows
              crossAxisSpacing: 8,
            ),
            itemCount: listData.length, // Number of items in each GridView
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/flim-detail',
                      arguments: listData[index]);
                },
                child: Stack(fit: StackFit.expand, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        // Adjust the height as needed
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                            image: listData[index]['poster_path'] != null
                                ? NetworkImage(
                                    listData[index]['poster_path'] as String)
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
                      margin: const EdgeInsets.only(left: 10, right: 10),
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
              );
            },
          ),
        ),
      ],
    );
  }
}

class shows_list1 extends StatelessWidget {
  const shows_list1({
    super.key,
    required this.listData1,
  });

  final List listData1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/nav-list',
            );
          },
          title: const Text(
            "Movies",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Set fontWeight to bold
            ),
          ),
          subtitle: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('Provides with an extensive Movie catalog '),
            ],
            onTap: () {},
            totalRepeatCount: 5,
            pause: const Duration(milliseconds: 2000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          trailing: const Icon(
            Icons.chevron_right,
            size: 35,
          ),
        ),
        Container(
          height: 230,

          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Warna bayangan
                spreadRadius: 1, // Seberapa jauh bayangan menyebar
                blurRadius: 1, // Seberapa kabur bayangan
                offset: const Offset(
                    0, 3), // Posisi bayangan (horizontal, vertical)
              ),
            ],
          ),
          // Adjust the height of the GridView as needed
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Number of Rows
              crossAxisSpacing: 8,
            ),
            itemCount: listData1.length, // Number of items in each GridView
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/flim-detail',
                      arguments: listData1[index]);
                },
                child: Stack(fit: StackFit.expand, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        // Adjust the height as needed
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          image: DecorationImage(
                            image: listData1[index]['poster_path'] != null
                                ? NetworkImage(
                                    listData1[index]['poster_path'] as String)
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
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Text(
                        listData1[index]['title'] ?? 'No title',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ],
    );
  }
}
