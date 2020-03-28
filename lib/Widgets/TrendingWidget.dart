import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingNEWS extends StatelessWidget {
  final String imageurl;
  final String title;

  const TrendingNEWS({Key key, this.imageurl, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
                padding: EdgeInsets.only(top: 30, left: 15),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Trending News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(48),
                      fontWeight: FontWeight.w300),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
                // color: Colors.red,
                width: ScreenUtil().setWidth(900),
                padding: EdgeInsets.only(bottom: 35, left: 20),
                alignment: Alignment.bottomLeft,
                child: Text(
                  '$title',
                  style: TextStyle(
                      color: imageurl != null ? Colors.white : Colors.red,
                      fontSize: ScreenUtil().setSp(60)),
                  maxLines: 3,
                )),
          ),
        ],
      ),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          // color: Colors.blue,
          image: DecorationImage(
              image: imageurl != null
                  ? NetworkImage(imageurl)
                  : NetworkImage("https://picsum.photos/250?image=9"),
              fit: BoxFit.fill)),
    );
  }
}

class ShimmerTrendingNEWS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
                padding: EdgeInsets.only(top: 30, left: 15),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Trending News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(48),
                      fontWeight: FontWeight.w300),
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(bottom: 0, left: 20),
                padding: EdgeInsets.only(top: 130),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(800),
                      color: Colors.grey[500],
                    ),
                    Container(
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(700),
                      color: Colors.grey[500],
                    ),
                    Container(
                      height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(600),
                      color: Colors.grey[500],
                    ),
                  ],
                )),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: Colors.blue,
      ),
    );
  }
}
