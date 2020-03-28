import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news/Api/NEWSApiLogic.dart';
import 'package:news/JsonMainpulator/TrendingNEWS.dart';
import 'package:shimmer/shimmer.dart';

import 'TrendingWidget.dart';

class TrendingAppbar extends StatefulWidget {
  @override
  _TrendingAppbarState createState() => _TrendingAppbarState();
}

class _TrendingAppbarState extends State<TrendingAppbar> {
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );
@override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
  void _pageanimations(int pagesize) {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < pagesize) {
        _currentPage++;
        // print("rans"+_currentPage.toString());
      } else {
        _currentPage=0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });

    
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating: true,
      // elevation: 8,
      // snap: true,
      expandedHeight: ScreenUtil().setHeight(1000),
      // pinned: true,
      onStretchTrigger: () async {
        
    _pageController.dispose();
      },
      backgroundColor: Colors.grey[300],
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(1000),
              child: FutureBuilder(
                future: NewsApiLogic().trendingNEWS(),
                builder: (context, trendData) {
                  if (trendData.hasData) {
                    try {
                      var trendingdata = trendingNewsFromJson(trendData.data);
                      _pageanimations(trendingdata.articles.length);
                      return PageView.builder(
                        
                        controller: _pageController,
                        pageSnapping: true,
                        itemCount: trendingdata.articles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WebviewScaffold(
                                        appBar: AppBar(title: Text("Webview"),),
                                        url: trendingdata.articles[index].url,
                                      )));
                            },
                            child: TrendingNEWS(
                              title: trendingdata.articles[index].title,
                              imageurl: trendingdata.articles[index].urlToImage,
                            ),
                          );
                        },
                      );
                    } catch (e) {
                      // print(e.toString());
                      var errordata = newsAPiErrorFromJson(trendData.data);
                      return PageView.builder(
                        controller: _pageController,
                        pageSnapping: false,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return TrendingNEWS(
                            title:
                                errordata.message.toString().split(".").first,
                            // imageurl: errordata.message,
                          );
                        },
                      );
                    }
                  }
                  if (trendData.connectionState == ConnectionState.none &&
                      trendData.hasData == null) {
                    //print('project snapshot data is: ${projectSnap.data}');
                    return Container(
                        child: Center(
                      child: Text("no data Form API"),
                    ));
                  }
                  return Shimmer.fromColors(
                    period: Duration(seconds: 3),
                    baseColor: Colors.grey[500],
                    highlightColor: Colors.white,
                    child: ShimmerTrendingNEWS(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
