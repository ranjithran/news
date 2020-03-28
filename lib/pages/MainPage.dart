import 'package:connectivity/connectivity.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news/Api/NEWSApiLogic.dart';
import 'package:news/Data/DataForApp.dart';
import 'package:news/JsonMainpulator/TrendingNEWS.dart';
import 'package:news/Widgets/NewsFeed.dart';
import 'package:news/Widgets/Topics.dart';
import 'package:news/Widgets/Trendingappbar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shimmer/shimmer.dart';

import 'package:flutter_native_admob/flutter_native_admob.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var trendingdata;
  connectivityCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.

      print(connectivityResult.index.toString());
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print(connectivityResult.index.toString());
    } else {
      _showDialog();
    }
  }
  bool status=false;
  checkAdmobStatus() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  final defaults = <String, dynamic>{"ran": "ranjith"};
  await remoteConfig.setDefaults(defaults);
  await remoteConfig.fetch(expiration: const Duration(seconds: 0));
  await remoteConfig.activateFetched();
  if ('true' == remoteConfig.getString('admob')) {
    NativeAdmob().initialize(appID: getAppId());
    print("admob is started");
    setState(() {
      status=true;
    });  
  }else
  {
  setState(() {
    status=false;
  });
  }
  

}
  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("No Internet"),
          content: Text("please check internet connection "),
          actions: <Widget>[
            new FlatButton(
               child: Text("Try again"),
              //  onPressed: Res,
               onPressed: SystemNavigator.pop,
            ),
            // new FlatButton(
            //   child:Text("Connected"),
            //   onPressed: Navigator.of(context).pop,
            // )
          ],
        );
      }
    );
  }
  @override
  void initState() {
    super.initState();
    connectivityCheck();
    callbackFunction();
    checkAdmobStatus();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 2160, allowFontScaling: true);
    return Scaffold(
      body: SafeArea(
          child: DefaultTabController(
        length: topics.length,
        child: NestedScrollView(
          body: TabBarView(
            children: List<Widget>.generate(
              topics.length,
              (i) => Container(
                child: FutureBuilder(
                    future: functions(topics[i]),
                    builder: (BuildContext context, trendingData) {
                      if (trendingData.hasData) {
                        try {
                          trendingdata =
                              trendingNewsFromJson(trendingData.data);
                          return ListView.builder(
                            itemCount: trendingdata.articles.length != null
                                ? trendingdata.articles.length
                                : 10,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (BuildContext context, int index) {
                              return 
                              index % 3 == 1&& status==true
                                  ? NativeAdmobBannerView(
                                      adUnitID: getBannerAdUnitId(),
                                      //showMedia: true,
                                      style: BannerStyle.dark,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          9.0, 8.0, 8.0, 8.0),
                                    )
                                  : 
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                WebviewScaffold(
                                              appBar: AppBar(
                                                title: Text("Webview"),
                                              ),
                                              url: trendingdata
                                                  .articles[index].url,
                                            ),
                                          ),
                                        );
                                      },
                                      child: NewsFeed(
                                        image: trendingdata
                                            .articles[index].urlToImage,
                                        title:
                                            trendingdata.articles[index].title,
                                        author:
                                            trendingdata.articles[index].author,
                                      ),
                                    );
                            },
                          );
                        } catch (e) {
                          var errordata =
                              newsAPiErrorFromJson(trendingData.data);
                          return ListView.builder(
                            itemCount: 1,
                            padding: EdgeInsets.all(10),
                            itemBuilder: (BuildContext context, int index) {
                              return NewsFeed(
                                title: errordata.message,
                                author: errordata.code,
                              );
                            },
                          );
                        }
                      }
                      if (trendingData.connectionState ==
                              ConnectionState.none &&
                          trendingData.hasData == null) {
                        //print('project snapshot data is: ${projectSnap.data}');
                        return ListView.builder(
                          itemCount: 10,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (BuildContext context, int index) {
                            return Shimmer.fromColors(
                              period: Duration(seconds: 3),
                              baseColor: Colors.grey[400],
                              highlightColor: Colors.white,
                              direction: ShimmerDirection.ltr,
                              child: ShimmerNewsFeed(),
                            );
                          },
                        );
                      }
                      return ListView.builder(
                        itemCount: 10,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (BuildContext context, int index) {
                          return Shimmer.fromColors(
                            period: Duration(seconds: 3),
                            baseColor: Colors.grey[400],
                            highlightColor: Colors.white,
                            direction: ShimmerDirection.ltr,
                            child: ShimmerNewsFeed(),
                          );
                        },
                      );
                    }),
              ),
            ),
          ),
          headerSliverBuilder:
              (BuildContext context, bool innerboxIsScrollled) {
            return <Widget>[
              TrendingAppbar(),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                      indicatorColor: Colors.black,
                      indicatorWeight: 2,
                      isScrollable: true,
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: List<Widget>.generate(
                          topics.length,
                          (i) => Topicsbutton(
                                text: topics[i],
                              ))),
                ),
                pinned: true,
              ),
            ];
          },
        ),
      )),
    );
  }

  void callbackFunction() {
    OneSignal.shared
        .setNotificationReceivedHandler((OSNotification notification) {
      // will be called whenever a notification is received
      print("Rans phone as recived");
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // will be called whenever a notification is opened/button pressed.
      print(" clicked");
      final String _url =
          result.notification.payload.additionalData["url"].toString();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebviewScaffold(
                url: _url,
                appBar: AppBar(
                  title: Text("WebView"),
                ),
              )));
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // will be called whenever the subscription changes
      //(ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

Future<dynamic> functions(String topics) async {
  switch (topics) {
    case "Business":
      return NewsApiLogic().getTopBusinessHeadlinesNews();
      break;
    case "Entertainment":
      return NewsApiLogic().getTopEntertainmentHeadlinesNews();
      break;
    case "General":
      return NewsApiLogic().getTopGeneralHeadlinesNews();
      break;
    case "Health":
      return NewsApiLogic().getTopHealthHeadlinesNews();
      break;
    case "Science":
      return NewsApiLogic().getTopScienceHeadlinesNews();
      break;
    case "Sports":
      return NewsApiLogic().getTopSportHeadlinesNews();
      break;
    case "Technology":
      return NewsApiLogic().getTopTechnologyHeadlinesNews();
      break;
  }
}
