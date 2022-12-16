import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Setting",
          style: TextStyle(
              color: Colors.grey.shade200, fontSize: 25, fontFamily: 'cute'),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "About App",
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 20,
                      fontFamily: 'cute'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Few devices are equipped with a humidity sensor, but if your device has one, you will have the option to get the humidity directly from a weather service. If your device does not have the sensor, don't fret... We are able to take your location, determined by your device's GPS and with a little internet help, the app will show the humidity outdoors at your location.",
                style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 15,
                    fontFamily: 'cute'),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
