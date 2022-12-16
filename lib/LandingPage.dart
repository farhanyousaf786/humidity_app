import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Model/Constans.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();

    //getData();
  }

   late String getThemeColor;
  String getNeverShowAgain = "false";

  void getLocationData() async {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Constants.mainPrimaryColor,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.white24.withOpacity(0.6)),
                  )),
            ),
            Column(
              children: [
                Text(
                  "Collecting Data...",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Names"),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Thank You For patience",
                  style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Names"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
