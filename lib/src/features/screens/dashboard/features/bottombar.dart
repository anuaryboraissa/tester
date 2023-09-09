import 'package:erisiti/src/constants/styles/style.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation(
      {super.key, required this.currentPage, required this.userType});
  final String userType;
  final Function(int currentPage) currentPage;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 0.1,
                color: ApplicationStyles.realAppColor)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = 0;
                    widget.currentPage(0);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentPage == 0
                          ? ApplicationStyles.realAppColor
                          : null,
                    ),
                    Text(
                      "Home",
                      style: ApplicationStyles.getStyle(
                          false,
                          10,
                          currentPage == 0
                              ? ApplicationStyles.realAppColor
                              : null),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = 1;
                    widget.currentPage(1);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.receipt,
                      color: currentPage == 1
                          ? ApplicationStyles.realAppColor
                          : null,
                    ),
                    Text("Receipts",
                        style: ApplicationStyles.getStyle(
                            false,
                            10,
                            currentPage == 1
                                ? ApplicationStyles.realAppColor
                                : null))
                  ],
                ),
              ),
              if (widget.userType == "BUSINESS")
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = 4;
                      widget.currentPage(4);
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.iso,
                        color: currentPage == 4
                            ? ApplicationStyles.realAppColor
                            : null,
                      ),
                      Text("Issue",
                          style: ApplicationStyles.getStyle(
                              false,
                              10,
                              currentPage == 4
                                  ? ApplicationStyles.realAppColor
                                  : null))
                    ],
                  ),
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = 3;
                    widget.currentPage(3);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.newspaper_rounded,
                      color: currentPage == 3
                          ? ApplicationStyles.realAppColor
                          : null,
                    ),
                    Text("Tips",
                        style: ApplicationStyles.getStyle(
                            false,
                            10,
                            currentPage == 3
                                ? ApplicationStyles.realAppColor
                                : null))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = 2;
                    widget.currentPage(2);
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.more_horiz_outlined,
                      color: currentPage == 2
                          ? ApplicationStyles.realAppColor
                          : null,
                    ),
                    Text("More",
                        style: ApplicationStyles.getStyle(
                            false,
                            10,
                            currentPage == 2
                                ? ApplicationStyles.realAppColor
                                : null))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
