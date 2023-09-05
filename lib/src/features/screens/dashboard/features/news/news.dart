import 'package:erisiti/src/features/screens/dashboard/features/news/components/body.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text("News & Updates",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  Row(
                    children: <Widget>[
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.search,
                              size: 30, color: Colors.blue)),
                      IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.notifications,
                              size: 30, color: Colors.blue))
                    ],
                  )
                ],
              ),
            ),
            const Expanded(child: NewsBody()),
          ],
        ),
      ),
    );
  }
}
