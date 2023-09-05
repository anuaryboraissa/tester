import 'dart:math';

import 'package:erisiti/src/features/screens/dashboard/features/news/helper.dart';
import 'package:flutter/material.dart';

class RecentCard extends StatefulWidget {
  const RecentCard(
      {super.key,
      required this.title,
      required this.author,
      required this.time,
      required this.viewers});
  final String title;
  final String author;
  final String time;
  final String viewers;

  @override
  State<RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<RecentCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width * 0.80,
      // height: MediaQuery.of(context).size.width * 0.90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * .24,
            height: size.height * .16,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                NewsSample.images[Random().nextInt(4) + 0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: size.width * .63, child: Text(widget.author)),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: size.width * .63,
                          child: Text(
                            widget.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 15,
                      ),
                      const SizedBox(width: 3.0),
                      Text(
                        widget.time,
                      )
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        size: 15,
                      ),
                      const SizedBox(width: 3.0),
                      Text(
                        widget.viewers,
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
