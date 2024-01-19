import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FlimListPageShows extends StatefulWidget {
  const FlimListPageShows({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FlimListPageShowsState createState() => _FlimListPageShowsState();
}

class _FlimListPageShowsState extends State<FlimListPageShows> {
  List listData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    EasyLoading.show();
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
                  Navigator.pushNamed(context, '/flim-detail',
                      arguments: listData[index]);
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(listData[index]['poster_path']),
                ),
                title: Text(listData[index]['title']),
              ),
            );
          },
        ),
      ),
    );
  }
}
