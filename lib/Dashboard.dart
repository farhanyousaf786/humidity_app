import 'package:countup/countup.dart';
import 'package:facebook_audience_network/ad/ad_interstitial.dart';
import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LandingPage.dart';
import 'Model/Constans.dart';
import 'Widgets/AllDataFunctions.dart';
import 'Widgets/setting.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ///**********Variables***********\\\

  String address = "";
  bool isInternet = false;

  // String apiKey = "21f4452f4c490db36e00e697213544de";
  String apiKey = "dd6359b8920c1a71d2561dc152d6ad3f";
  double temperatureC = 0.0;
  double temperatureF = 0.0;
  double temperatureK = 0.0;
  double feelsLikeC = 0.0;
  double feelsLikeF = 0.0;

  // late String description;

  var humidity = 0;
  bool isCelcius = true;
  double insideTemperatureC = 0;
  double insideTemperatureF = 0;
  bool isOutSideTemp = false;

  ///**********To get Location an also run other functions ***********\\\

  void updateIu(dynamic weatherData, dynamic locationInfo) {
    setState(() {
      if (weatherData == null) {
        temperatureC = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      humidity = weatherData['main']['humidity'];
      double feels = weatherData['main']['feels_like'];
      // description = weatherData['weather']['description'];

      temperatureC = temp - 273;
      temperatureF = temperatureC * 9 / 5 + 32;
      feelsLikeC = feels - 273;
      feelsLikeF = feelsLikeC * 9 / 5 + 32;

      print("outC: $temperatureC");
      print("outF: $temperatureF");
      print("feelsLikeC: $feelsLikeC");
      print("feelsLikeF: $feelsLikeF");
      // print("descriptiom : $description");

      address = locationInfo;
    });
  }

  Future<void> getInsideTemp() async {
    print("getInsideTemp() is run");
    final geoLocation = Provider.of<AllFunctions>(context, listen: false);
    await geoLocation.initDeviceTemperature();

    setState(() {
      insideTemperatureC = geoLocation.insideTemperatureC.toDouble();
      insideTemperatureF = geoLocation.insideTemperatureF.toDouble();
    });

    print("insideC $insideTemperatureC}");
    print("insideF $insideTemperatureF}");
  }

  ///**********Location Widgets shown here***********\\\

  _location() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: address == ""
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 20, color: Constants.mainPrimaryColor),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Collecting Data",
                        style: TextStyle(
                            color: Constants.mainPrimaryColor,
                            fontFamily: "Names",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Constants.mainPrimaryColor,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Constants.mainPrimaryColor2),
                          )),
                    ],
                  )
                : Text(
                    "$address",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainPrimaryColor,
                        fontFamily: "Names",
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
          )
        ],
      ),
    );
  }

  ///**********This is Function to change Scale***********\\\

  scaleController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Constants.mainPrimaryColor,
              borderRadius: BorderRadius.circular(10.0),
              elevation: 2,
              shadowColor: Constants.mainPrimaryColor,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 80,
                child: Text(
                  "°C",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Names",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          onTap: () => {
            setState(() {
              // _showInterstitialAd();

              isCelcius = true;
            }),
          },
        ),
        GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Constants.mainPrimaryColor,
                borderRadius: BorderRadius.circular(10.0),
                elevation: 2,
                shadowColor: Constants.mainPrimaryColor,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 80,
                  child: Text(
                    "°F",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Names",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            onTap: () => {
                  setState(() {
                    // Future.delayed(const Duration(seconds: 5), () {
                    //   _showInterstitialAd();
                    // });
                    isCelcius = false;
                  }),
                }),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Constants.mainPrimaryColor,
                borderRadius: BorderRadius.circular(10.0),
                elevation: 2,
                shadowColor: Constants.mainPrimaryColor,
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 80,
                  child: Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandingPage(),
                    ),
                  )
                }),
        SizedBox(
          width: 12,
        ),
      ],
    );
  }

  ///**********Setting button is here***********\\\

  _getCurrentLocation() async {
    try {
      AllFunctions allFunctions = AllFunctions();
      var weatherData = await allFunctions.getLocationWeather();
      var locationData = await allFunctions.getLocation();

      updateIu(weatherData, locationData);
    } catch (e) {
      setState(() {
        isInternet = true;
      });

      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.3),
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Internet Missing",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
          ),
          content:
              Text("Please turn on Your Mobile Data or Wifi & Restart the App"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => {SystemNavigator.pop()},
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  ///***Alert dialogue***\\\

  String neverShowAgain;

  alertDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    neverShowAgain = prefs.getString("neverShowAgain");

    if (neverShowAgain != null) {
      return Text("");
    } else {
      return Future.delayed(const Duration(seconds: 5), () {
        showDialog(
          barrierDismissible: false,
          barrierColor: Colors.white.withOpacity(0.6),
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Constants.mainPrimaryColor2,
            title: Text(
              "Room Temperature!",
              style: TextStyle(
                  color: Colors.yellowAccent, fontWeight: FontWeight.w700),
            ),
            content: Text(
              "Keep Your Device Away From Cold or Hot Things To Measure Accurate Room Temperature, Thank You!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => {
                  prefs.setString("neverShowAgain", "True"),
                  Navigator.pop(context),
                },
                child: Text(
                  "Never Show Again",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    createInterAds();


    loadBannerAd();
    alertDialog();
    Future.delayed(const Duration(seconds: 10), () {
      showInterAds();

      print("show ad");
    });
    _getCurrentLocation();
    getInsideTemp();
  }

  // This is ad Area for Switch Shot Meme
  BannerAd myBanner1;
  bool isLoaded1 = false;

  void loadBannerAd() {
    myBanner1 = BannerAd(
        adUnitId: 'ca-app-pub-5525086149175557/4458175055',
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isLoaded1 = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();

          print('ad failed to load ${error.message}');
        }));

    myBanner1.load();
  }

  static const AdRequest request = AdRequest(
      // keywords: ['', ''],
      // contentUrl: '',
      // nonPersonalizedAds: false
      );

  // This is ad Area for Switch Shot Meme
  InterstitialAd myInterAd1;
  bool isInterAdLoaded = false;
  int numberOfAttempts = 0;

  void createInterAds() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-5525086149175557/5913042743',
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        myInterAd1 = ad;
        numberOfAttempts = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        numberOfAttempts = numberOfAttempts + 1;
        myInterAd1 = null;

        if (numberOfAttempts <= 2) {
          createInterAds();
        }
      }),
    );
  }

  void showInterAds() {
    if (myInterAd1 == null) {
      print("...ad null");
      return;
    } else {
      myInterAd1.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("On Adshown Full screen");
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad OnAdFailed $error');
        ad.dispose();
        createInterAds();
      });
      myInterAd1.show();
      myInterAd1 = null;
    }

    myInterAd1.show();
    myInterAd1 = null;
  }

  Widget indoorTemp() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Indoor Temp",
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey.shade200,
                fontFamily: 'cute',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Countup(
                  begin: -10,
                  end: !isCelcius
                      ? insideTemperatureF - 8
                      : insideTemperatureC - 3,
                  duration: Duration(seconds: 2),
                  separator: ',',
                  style: TextStyle(
                      color: Constants.mainPrimaryColor,
                      fontSize: 50,
                      fontFamily: 'cutes',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isCelcius ? "°C" : "°F",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'cute',
                      color: Constants.mainPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Feels Like",
                style: TextStyle(
                    fontSize: 15,
                    color: Constants.mainPrimaryColor,
                    fontFamily: 'cutes',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Countup(
                begin: -10,
                end: !isCelcius ? feelsLikeF : feelsLikeC,
                duration: Duration(seconds: 2),
                separator: ',',
                style: TextStyle(
                    color: Constants.mainPrimaryColor,
                    fontSize: 13,
                    fontFamily: 'cutes',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                isCelcius ? "°C" : "°F",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'cute',
                  color: Constants.mainPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget outDoorTemp() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Outdoor Temp",
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey.shade200,
                fontFamily: 'cute',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Countup(
                  begin: -10,
                  end: !isCelcius ? temperatureF : temperatureC,
                  duration: Duration(seconds: 2),
                  separator: ',',
                  style: TextStyle(
                      color: Constants.mainPrimaryColor,
                      fontSize: 50,
                      fontFamily: 'cutes',
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isCelcius ? "°C" : "°F",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'cute',
                      color: Constants.mainPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Feels Like",
                style: TextStyle(
                    fontSize: 15,
                    color: Constants.mainPrimaryColor,
                    fontFamily: 'cutes',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Countup(
                begin: -10,
                end: !isCelcius ? feelsLikeF : feelsLikeC,
                duration: Duration(seconds: 2),
                separator: ',',
                style: TextStyle(
                    color: Constants.mainPrimaryColor,
                    fontSize: 13,
                    fontFamily: 'cutes',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                isCelcius ? "°C" : "°F",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'cute',
                  color: Constants.mainPrimaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///**********Main Widgets***********\\\

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue.shade300,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Humidity",
                style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 25,
                    fontFamily: 'cute'),
              ),
              actions: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SettingPage()));
                  },
                )
              ],
            ),
            backgroundColor: Colors.blue.shade300,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            child: Lottie.asset('images/humidity.json'),
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            child: LiquidCircularProgressIndicator(
                              value: humidity.toDouble() / 100,
                              // Defaults to 0.5.
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.blue.shade400),
                              // Defaults to the current Theme's accentColor.
                              backgroundColor: Colors.blue.shade200,
                              // Defaults to the current Theme's backgroundColor.
                              borderColor: Colors.blue.shade700,
                              borderWidth: 6.0,
                              direction: Axis.vertical,
                              center: Text(
                                humidity.toString() + "%",
                                style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontSize: 30,
                                    fontFamily: 'Cute'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _location(),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 0),
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    outDoorTemp(),

                    // _showHumidity(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 0),
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    indoorTemp(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [scaleController()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          left: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: AdWidget(
                ad: myBanner1,
              ),
              width: myBanner1.size.width.toDouble(),
              height: myBanner1.size.height.toDouble(),
            ),
          ),
        )
      ],
    );
  }
}
