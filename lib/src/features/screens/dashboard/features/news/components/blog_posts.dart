import 'dart:math';

import 'package:erisiti/src/features/screens/dashboard/features/news/helper.dart';
import 'package:flutter/material.dart';

class BlogPosts extends StatefulWidget {
  const BlogPosts({super.key});

  @override
  State<BlogPosts> createState() => _BlogPostsState();
}

class _BlogPostsState extends State<BlogPosts> {
  List samples = [];
  @override
  void initState() {
    getSample();
    super.initState();
  }

  getSample() {
    NewsSample().readJsonFile().then((value) {
      setState(() {
        samples = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.width * 0.90,
      child: samples.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: samples.length,
              itemBuilder: (context, index) {
                print("item $index");
                Map item = samples[index];
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0),
                    child: Stack(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 4.0),
                                blurRadius: 10.0,
                                spreadRadius: 0.10)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: Image.asset(
                            NewsSample.images[Random().nextInt(4 - 0) + 0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 10,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Text(
                                    item['title'],
                                    style: const TextStyle(
                                      // overflow: TextOverflow.ellipsis,
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 10.0,
                                        backgroundImage: AssetImage(
                                            NewsSample.images[
                                                Random().nextInt(4 - 0) + 0])),
                                    const SizedBox(width: 8.0),
                                    Text(
                                        item['creator'] != null
                                            ? item['creator'][0]
                                            : "None",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0)),
                                  ],
                                )
                              ])),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: Row(children: [
                            const Icon(
                              Icons.timer,
                              size: 10.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8.0),
                            Text(item['pubDate'].toString().split(" ")[0],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14.0))
                          ])),
                    ]),
                  ),
                );
              },
            ),
    );
  }
}
