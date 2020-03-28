import 'package:connectivity/connectivity.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/pages/MainPage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permissions_plugin/permissions_plugin.dart';
import 'Data/DataForApp.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import "package:news/AppKeys.dart" as keys;
void main() {
  if (WidgetsFlutterBinding.ensureInitialized().isRootWidgetAttached) {
    premission();
    checkAdmobStatus();
  }

  runApp(
    MaterialApp(
      home: MainPage(),
      // home: MyApp(),
      debugShowCheckedModeBanner: false,
      title: "NEWS",
    ),
  );
    // onesdkInt();
    OneSignal.shared.init(keys.onesdkKey, iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: true
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}

checkAdmobStatus() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  final defaults = <String, dynamic>{"ran": "ranjith"};
  await remoteConfig.setDefaults(defaults);
  await remoteConfig.fetch(expiration: const Duration(seconds: 0));
  await remoteConfig.activateFetched();
  if ('true' == remoteConfig.getString('admob')) {
    NativeAdmob().initialize(appID: getAppId());
    print("admob is started");
    return true;  
  }
  return false;

}

premission() async {
  await PermissionsPlugin.requestPermissions([
    Permission.ACCESS_FINE_LOCATION,
    Permission.ACCESS_COARSE_LOCATION,
  ]);
}

onesdkInt() {
  OneSignal.shared.init(keys.onesdkKey, iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: true
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const adUnitID = keys.adsKeys;
  final _nativeAdmob = NativeAdmob();
  

  @override
  void initState() {
    super.initState();
    _nativeAdmob.initialize(appID: keys.ads2Keys);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            // NativeAdmobBannerView(
            //   adUnitID: adUnitID,
            //   showMedia: true,
            //   style: BannerStyle.dark,
            //   contentPadding: EdgeInsets.fromLTRB(9.0, 8.0, 8.0, 8.0),
            // ),
            RaisedButton(
              onPressed: () {
              },
            )
          ],
        ),
      ),
    );
  }
}
