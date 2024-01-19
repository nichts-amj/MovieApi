import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailFlimPage extends StatefulWidget {
  const DetailFlimPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MahasiswaDetailPageState createState() => _MahasiswaDetailPageState();
}

class _MahasiswaDetailPageState extends State<DetailFlimPage> {
  @override
  Widget build(BuildContext context) {
    final dataflim = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text(dataflim['title']),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Center(
                    child: Image.network(
                      dataflim['poster_path'],
                      width: 200,
                      height: 300,
                      fit:
                          BoxFit.cover, // Ensure the image covers its container
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            dataflim['title'],
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Center(
                        //   child: ElevatedButton(
                        //     style: ButtonStyle(
                        //       backgroundColor: MaterialStateProperty.all<Color>(
                        //           Colors.redAccent),
                        //     ),
                        //     onPressed: () {
                        //       _showBottomSheet(
                        //           context, dataflim["youtube_trailer"]);
                        //     },
                        //     child: Text("Watch Trailer"),
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Release Date : ",
                                    style: TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${dataflim['release_date'] ?? 'Not available'}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            const Text(
                              "Overview : ",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${dataflim['overview']}",
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                              maxLines:
                                  20, // Sesuaikan jumlah baris yang diinginkan
                              overflow: TextOverflow
                                  .ellipsis, // Tambahkan ellipsis jika terjadi overflow
                            ),
                            const SizedBox(height: 16),

                            // Add the button here
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// void _showBottomSheet(BuildContext context, String data) {
//   // Convert YouTube URL to video ID inside the method
//   String videoUrl = data;
//   String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(25.0),
//       ),
//     ),
//     builder: (BuildContext context) {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           // Example YouTube Player
//           Container(
//             padding: EdgeInsets.all(10),
//             margin: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 color: Colors.black),
//             child: YoutubePlayer(
//               controller: YoutubePlayerController(
//                 initialVideoId: videoId!,
//                 flags: YoutubePlayerFlags(
//                   autoPlay: true,
//                   mute: false,
//                 ),
//               ),
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Colors.blue,
//               progressColors: ProgressBarColors(
//                 playedColor: Colors.blue,
//                 handleColor: Colors.blue,
//               ),
//               onReady: () {},
//               onEnded: (YoutubeMetaData metaData) {
//                 // Add any logic here
//               },
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
