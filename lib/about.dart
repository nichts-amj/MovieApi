import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final List<Map<String, String>> gridData = [
    {'avatarAsset': 'assets/111.jpg', 'title': 'Admaja'},
    {'avatarAsset': 'assets/111.jpg', 'title': 'Adryan'},
    {'avatarAsset': 'assets/111.jpg', 'title': 'Arif Erazzak'},
    {'avatarAsset': 'assets/111.jpg', 'title': 'M. Marsel Al Furqon'},
    {'avatarAsset': 'assets/111.jpg', 'title': 'M. Ilham Juliansyah'},
    {'avatarAsset': 'assets/111.jpg', 'title': 'Defry Nazrian'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
                child: Image.asset(
                  'assets/logo-no-background.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'MoviesL',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          newMethod,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),

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
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
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
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Developer By', // Add your text here
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: gridData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildGridItem(gridData[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.manage_accounts,
        ),
      ),
    );
  }

  String get newMethod =>
      "Experience the future of entertainment data integration with our premium API solution. Elevate your application’s capabilities with seamless access to comprehensive movie and TV show information, boasting advanced filtering options. Our API is the definitive source for crucial streaming service data, including Netflix, Prime, Disney, HBO, Hulu, and many others. Empower your users to effortlessly discover the latest content available on their preferred platforms. Stay at the forefront of the industry and enhance your app or service’s entertainment offerings.";
}

Widget _buildGridItem(Map<String, String> item) {
  return Card(
    child: Column(
      children: [
        Expanded(
          child: Image.asset(
            item['avatarAsset']!, // Corrected key here
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            item['title']!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
