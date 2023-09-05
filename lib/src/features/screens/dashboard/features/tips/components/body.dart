import 'package:erisiti/src/constants/data/business.dart';
import 'package:erisiti/src/features/screens/dashboard/features/tips/bloc/home_tips_bloc.dart';
import 'package:erisiti/src/features/screens/dashboard/features/tips/components/tip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeTipsBody extends StatefulWidget {
  const HomeTipsBody({super.key, required this.size});
  final Size size;

  @override
  State<HomeTipsBody> createState() => _HomeTipsBodyState();
}

class _HomeTipsBodyState extends State<HomeTipsBody> {
  HomeTipsBloc homeTipsBloc = HomeTipsBloc();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: BlocBuilder<HomeTipsBloc, HomeTipsState>(
        bloc: homeTipsBloc,
        builder: (context, state) {
          return SizedBox(
            height: widget.size.height * .78,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) {
                    homeTipsBloc.add(SearchTipsEvent(value));
                  },
                  decoration: InputDecoration(
                      hintText: "Search your business here!",
                      contentPadding: const EdgeInsets.all(20),
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                Expanded(
                    child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 60),
                  itemCount: (state is SearchTipsState)
                      ? state.tips.length
                      : AvailableTips.tips.length,
                  itemBuilder: (context, index) {
                    Map item = (state is SearchTipsState)
                        ? state.tips[index]
                        : AvailableTips.tips[index];
                    return TipsCard(
                      image: item['image'],
                      title: item['name'],
                      description: item['description'],
                      size: widget.size,
                      itemId: item['id'].toString(),
                      callback: (String itemID) {
                        Fluttertoast.showToast(msg: "Item Clicked $itemID");
                      },
                    );
                  },
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
