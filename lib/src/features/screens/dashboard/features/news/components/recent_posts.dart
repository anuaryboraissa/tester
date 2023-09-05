import 'package:erisiti/src/features/screens/dashboard/features/news/components/recent_card.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class RecentPosts extends StatefulWidget {
  const RecentPosts({super.key, required this.scrolling});
  final Function(bool bottom) scrolling;

  @override
  State<RecentPosts> createState() => _RecentPostsState();
}

class _RecentPostsState extends State<RecentPosts> {
  List samples = [];
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    getSample();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        widget.scrolling(true);
      }
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        widget.scrolling(false);
      }
    });
  }

  getSample() {
    NewsSample().readJsonFile().then((value) {
      setState(() {
        samples = value;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .72,
      child: samples.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: samples.length,
              itemBuilder: (context, index) {
                Map item = samples[index];
                return RecentCard(
                    title: item['title'],
                    author:
                        item['creator'] != null ? item['creator'][0] : "None",
                    time: item['pubDate'].toString().split(" ")[0],
                    viewers: "1 view");
              },
            ),
    );
  }
}
