// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'Widgets/AllDataFunctions.dart';
import 'LandingPage.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor:  Colors.blue.shade300,
    // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AllFunctions>(create: (_) => AllFunctions()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Thermometer',
          home: new LandingPage(),),
    );
  }
}

//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(MyApp());
// }
//
// // You can also test with your own ad unit IDs by registering your device as a
// // test device. Check the logs for your device's ID value.
// const String testDevice = 'YOUR_DEVICE_ID';
// const int maxFailedLoadAttempts = 3;
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   static final AdRequest request = AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );
//
//   InterstitialAd _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;
//
//   RewardedAd _rewardedAd;
//   int _numRewardedLoadAttempts = 0;
//
//   BannerAd _anchoredBanner;
//   bool _loadingAnchoredBanner = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//     _createRewardedAd();
//   }
//
//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: InterstitialAd.testAdUnitId,
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }
//
//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd.show();
//     _interstitialAd = null;
//   }
//
//   void _createRewardedAd() {
//     RewardedAd.load(
//         adUnitId: RewardedAd.testAdUnitId,
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('$ad loaded.');
//             _rewardedAd = ad;
//             _numRewardedLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             _numRewardedLoadAttempts += 1;
//             if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
//               _createRewardedAd();
//             }
//           },
//         ));
//   }
//
//   void _showRewardedAd() {
//     if (_rewardedAd == null) {
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedAd();
//       },
//     );
//
//     _rewardedAd.setImmersiveMode(true);
//     _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
//     });
//     _rewardedAd = null;
//   }
//
//   Future<void> _createAnchoredBanner(BuildContext context) async {
//     final AnchoredAdaptiveBannerAdSize size =
//     await AdSize.getAnchoredAdaptiveBannerAdSize(
//       Orientation.portrait,
//       MediaQuery.of(context).size.width.truncate(),
//     );
//
//     if (size == null) {
//       print('Unable to get height of anchored banner.');
//       return;
//     }
//
//     final BannerAd banner = BannerAd(
//       size: size,
//       request: request,
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/6300978111'
//           : 'ca-app-pub-3940256099942544/2934735716',
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$BannerAd loaded.');
//           setState(() {
//             _anchoredBanner = ad as BannerAd;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$BannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//       ),
//     );
//     return banner.load();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//     _anchoredBanner?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (BuildContext context) {
//         if (!_loadingAnchoredBanner) {
//           _loadingAnchoredBanner = true;
//           _createAnchoredBanner(context);
//         }
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('AdMob Plugin example app'),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: (String result) {
//                   switch (result) {
//                     case 'InterstitialAd':
//                       _showInterstitialAd();
//                       break;
//                     case 'RewardedAd':
//                       _showRewardedAd();
//                       break;
//                     default:
//                       throw AssertionError('unexpected button: $result');
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   PopupMenuItem<String>(
//                     value: '$InterstitialAd',
//                     child: Text('$InterstitialAd'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: '$RewardedAd',
//                     child: Text('$RewardedAd'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: SafeArea(
//             child: Stack(
//               alignment: AlignmentDirectional.bottomCenter,
//               children: <Widget>[
//                 ReusableInlineExample(),
//                 if (_anchoredBanner != null)
//                   Container(
//                     color: Colors.green,
//                     width: _anchoredBanner.size.width.toDouble(),
//                     height: _anchoredBanner.size.height.toDouble(),
//                     child: AdWidget(ad: _anchoredBanner),
//                   ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
//
// class Constants {
//   /// Placeholder text.
//   static const String placeholderText =
//       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'
//       ' tempor incididunt ut labore et dolore magna aliqua. Faucibus purus in'
//       ' massa tempor. Quis enim lobortis scelerisque fermentum dui faucibus'
//       ' in. Nibh praesent tristique magna sit amet purus gravida quis.'
//       ' Magna sit amet purus gravida quis blandit turpis cursus in. Sed'
//       ' adipiscing diam donec adipiscing tristique. Urna porttitor rhoncus'
//       ' dolor purus non enim praesent. Pellentesque habitant morbi tristique'
//       ' senectus et netus. Risus ultricies tristique nulla aliquet enim tortor'
//       ' at.';
// }
//
//
// /// This example demonstrates inline ads in a list view, where the ad objects
// /// live for the lifetime of this widget.
// class ReusableInlineExample extends StatefulWidget {
//   @override
//   _ReusableInlineExampleState createState() => _ReusableInlineExampleState();
// }
//
// class _ReusableInlineExampleState extends State<ReusableInlineExample> {
//   BannerAd _bannerAd;
//   bool _bannerAdIsLoaded = false;
//
//   AdManagerBannerAd _adManagerBannerAd;
//   bool _adManagerBannerAdIsLoaded = false;
//
//   NativeAd _nativeAd;
//   bool _nativeAdIsLoaded = false;
//
//   @override
//   Widget build(BuildContext context) => Center(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: ListView.separated(
//         itemCount: 20,
//         separatorBuilder: (BuildContext context, int index) {
//           return Container(
//             height: 40,
//           );
//         },
//         itemBuilder: (BuildContext context, int index) {
//           final BannerAd bannerAd = _bannerAd;
//           if (index == 5 && _bannerAdIsLoaded && bannerAd != null) {
//             return Container(
//                 height: bannerAd.size.height.toDouble(),
//                 width: bannerAd.size.width.toDouble(),
//                 child: AdWidget(ad: bannerAd));
//           }
//
//           final AdManagerBannerAd adManagerBannerAd = _adManagerBannerAd;
//           if (index == 10 &&
//               _adManagerBannerAdIsLoaded &&
//               adManagerBannerAd != null) {
//             return Container(
//                 height: adManagerBannerAd.sizes[0].height.toDouble(),
//                 width: adManagerBannerAd.sizes[0].width.toDouble(),
//                 child: AdWidget(ad: _adManagerBannerAd));
//           }
//
//           final NativeAd nativeAd = _nativeAd;
//           if (index == 15 && _nativeAdIsLoaded && nativeAd != null) {
//             return Container(
//                 width: 250, height: 350, child: AdWidget(ad: nativeAd));
//           }
//
//           return Text(
//             Constants.placeholderText,
//             style: TextStyle(fontSize: 24),
//           );
//         },
//       ),
//     ),
//   );
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Create the ad objects and load ads.
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/6300978111'
//             : 'ca-app-pub-3940256099942544/2934735716',
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             print('$BannerAd loaded.');
//             setState(() {
//               _bannerAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             print('$BannerAd failedToLoad: $error');
//             ad.dispose();
//           },
//           onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//           onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//         ),
//         request: AdRequest())
//       ..load();
//
//     _nativeAd = NativeAd(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/2247696110'
//           : 'ca-app-pub-3940256099942544/3986624511',
//       request: AdRequest(),
//       factoryId: 'adFactoryExample',
//       listener: NativeAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$NativeAd loaded.');
//           setState(() {
//             _nativeAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$NativeAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
//       ),
//     )..load();
//
//     _adManagerBannerAd = AdManagerBannerAd(
//       adUnitId: '/6499/example/banner',
//       request: AdManagerAdRequest(nonPersonalizedAds: true),
//       sizes: <AdSize>[AdSize.largeBanner],
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$AdManagerBannerAd loaded.');
//           setState(() {
//             _adManagerBannerAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$AdManagerBannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$AdManagerBannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$AdManagerBannerAd onAdClosed.'),
//       ),
//     )..load();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _bannerAd?.dispose();
//     _adManagerBannerAd?.dispose();
//     _nativeAd?.dispose();
//   }
// }