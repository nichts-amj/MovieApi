// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FlimdartPageShow extends StatefulWidget {
  const FlimdartPageShow({Key? key}) : super(key: key);

  @override
  _FlimdartPageShowState createState() => _FlimdartPageShowState();
}

class _FlimdartPageShowState extends State<FlimdartPageShow> {
  List listData = [];

  @override
  void initState() {
    super.initState();
    getData();
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
      listData = responJson['movies'];
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.7,
            ),
            itemCount: listData.length,
            itemBuilder: (BuildContext context, int index) {
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
                        height: 250, // Adjust the height as needed
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
          )),
    );
  }
}
