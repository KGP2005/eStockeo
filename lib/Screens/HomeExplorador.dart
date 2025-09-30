import 'package:flutter/material.dart';

class HomeExplorador extends StatefulWidget {
  @override
  _HomeExploradorState createState() => _HomeExploradorState();
}

class _HomeExploradorState extends State<HomeExplorador> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _posts = [
    {
      "image": "https://picsum.photos/500/800?1",
      "title": "Blusa de lino oversize",
      "brand": "ARINZA",
      "likes": 4345,
      "comments": 76,
      "shares": 1533,
    },
    {
      "image": "https://picsum.photos/500/800?2",
      "title": "Vestido casual verano",
      "brand": "MAGNIFICA",
      "likes": 2310,
      "comments": 45,
      "shares": 800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _posts.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final post = _posts[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(post["image"], fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 16,
                right: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post["title"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      post["brand"],
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Comprar",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.white, size: 32),
                    Text(
                      "${post["likes"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Icon(Icons.comment, color: Colors.white, size: 32),
                    Text(
                      "${post["comments"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Icon(Icons.share, color: Colors.white, size: 32),
                    Text(
                      "${post["shares"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
