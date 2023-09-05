import 'package:flutter/material.dart';

import 'blog_posts.dart';
import 'recent_posts.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({super.key});

  @override
  State<NewsBody> createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  late ScrollController scrollController;
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  void bottomScroll() {
    print("triggered");
    final bottomOffset = scrollController.position.maxScrollExtent;
    scrollController.animateTo(bottomOffset,
        duration: const Duration(microseconds: 1500), curve: Curves.easeOut);
  }

  void topScroll() {
    print("triggered");
    final bottomOffset = scrollController.position.minScrollExtent;
    scrollController.animateTo(bottomOffset,
        duration: const Duration(microseconds: 10), curve: Curves.easeOut);
  }

  var bottom;
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: <Widget>[
        Column(
          children: <Widget>[
            // FavAuthors(),

            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Popular Posts",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) =>
                        //       AllPosts(title: "Popular Posts"),
                        // ));
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const BlogPosts(),
            Container(
              // color: log_page,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Recent Posts",
                      style: TextStyle(
                          // color: log_txt,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.lightBlueAccent, fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            RecentPosts(
              scrolling: (bool status) {
                if (status) {
                  bottomScroll();
                } else {
                  topScroll();
                }
              },
            )
          ],
        )
      ],
    );
  }
}
