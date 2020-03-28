import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsFeed extends StatelessWidget {
  final String image;
  final String title;
  final String author;

  const NewsFeed({Key key, this.image, this.title, this.author})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        // color: Colors.blue.shade200,
        height: ScreenUtil().setHeight(350),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                width: ScreenUtil().setWidth(390),
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Image.network(image != null
                    ? image
                    : "https://picsum.photos/250?image=9"),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        title != null ? title : "No Title",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(33)),
                        maxLines: 3,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 23),
                    child: Text(
                      author != null ? author : "No Author",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(35)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class ShimmerNewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1))),
        // color: Colors.blue.shade200,
        height: ScreenUtil().setHeight(350),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Container(
                width: ScreenUtil().setWidth(300),
                margin: EdgeInsets.all(10),
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(600),
                      margin: EdgeInsets.only(top: 10),
                      color: Colors.grey,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(500),
                      // margin: EdgeInsets.only(top: 10),
                      color: Colors.grey,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(400),
                      // margin: EdgeInsets.only(top: 10),
                      color: Colors.grey,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(300),
                      padding: EdgeInsets.only(bottom: 23),
                      color: Colors.grey,
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 5, top: 8, bottom: 14),
              ),
            ),
          ],
        ));
  }
}
