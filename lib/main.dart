import 'package:flutter/material.dart';
import 'package:flutter_application/Showlist/navbarShow.dart';
import 'package:flutter_application/beranda.dart';
import 'package:flutter_application/button_navbar.dart';
import 'package:flutter_application/detail/detail_flim_page.dart';
import 'package:flutter_application/detail/detail_flim_page_cari.dart';
import 'package:flutter_application/movieslist/flim_list_page.dart';
import 'package:flutter_application/movieslist/navbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/gempa-list': (context) => const FlimListPage(),
        '/nav-list': (context) => const Navigasi(),
        '/flim-detail': (context) => const DetailFlimPage(),
        '/flim-detailCari': (context) => const DetailFlimPageCari(),
        '/navigasi': (context) => const ButtomNav(),
        '/beranda': (context) => const Beranda(),
        '/nav-show': (context) => const NavigasiShow(),
      },
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 41, 152, 226)),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_field
  int _counter = 0;

  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue, // Warna latar belakang merah
          ),
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [const Color.fromARGB(255, 253, 253, 253), Colors.redAccent],
                [
                  Colors.blue.withOpacity(0.8),
                  const Color.fromARGB(255, 244, 243, 243).withOpacity(0.8)
                ],
                [
                  Colors.blue.withOpacity(0.6),
                  const Color.fromARGB(255, 251, 251, 251).withOpacity(0.6)
                ],
                [
                  Colors.blue.withOpacity(0.4),
                  const Color.fromARGB(255, 255, 187, 187).withOpacity(0.4)
                ],
              ],
              durations: [5000, 4440, 3600, 2900],
              heightPercentages: [
                0.50,
                0.45,
                0.40,
                0.35,
              ], // Atur tinggi gelombang di sini
            ),
            waveAmplitude: 10,
            size: const Size(
              double.infinity,
              double.infinity,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'assets/logo-no-background.png',
                    width: 250,
                    height: 250,
                  ),
                ),
                const SizedBox(height: 265),
                Center(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Bobbers',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                            'Experience the future of entertainment'),
                        TyperAnimatedText(
                            'with seamless access to comprehensive'),
                        TyperAnimatedText(
                            'movie and TV show information boasting'),
                        TyperAnimatedText('and advanced filtering options.'),
                      ],
                      onTap: () {},
                      totalRepeatCount: 50,
                      pause: const Duration(milliseconds: 2000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/navigasi');
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 19),
                        ),
                      ),
                      child: const Text(
                        "  Start  ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
