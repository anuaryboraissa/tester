import 'package:erisiti/src/constants/styles/style.dart';
import 'package:erisiti/src/features/screens/dashboard/Business/RegisterBusiness/register.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.tinNumber});
  final String tinNumber;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * .03,
              ),
              Image.asset(
                "assets/images/welcome.png",
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Welcome to the Future of Receipt Management!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text(
                    "We are thrilled to welcome you to the world of seamless and efficient receipt management with our state-of-the-art Digital Receipt Application!"),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getContentItem(size),
                    getTitle(
                        "Receipt Customization",
                        "Receipt Generation",
                        "Real-time Data Entry",
                        "Receipt Storage",
                        "Compliance and Security",
                        "Offline Functionality",
                        size)
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: Text("More efficient and customer-friendly business"),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: ApplicationStyles.realAppColor),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterBusiness(
                    tinNumber: widget.tinNumber,
                  ),
                ));
              },
              child: const Text("Let's get started")),
        ),
      ),
    );
  }

  Widget getContentItem(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Icon(
          Icons.check,
          size: (size.height * .0095 * size.width * .0095),
          color: ApplicationStyles.realAppColor,
        ),
      ],
    );
  }

  Widget getTitle(String title1, String title2, String title3, String title4,
      String title5, String title6, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title1),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title2),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title3),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title4),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title5),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: size.height * .005, bottom: size.height * .018),
          child: Text(title6),
        ),
      ],
    );
  }
}
