import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = "正在获取数据";

  @override
  void initState() {
    // TODO: implement initState
    // 获取主页数据
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活家"),
      ),
      body: FutureBuilder(
        future: getHomePageContent(), //异步方法
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 有无数据
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); // 解析成List
            return Column(
              children: <Widget>[
                WpiperDiy(swiperDataList),
              ],
            );
          } else { //没有数据
            return Center(
              child: Text("加载中..."),
            );
          }
        },
      ), // 异步请求动态
    );
  }
}

// 首页轮播组件
class WpiperDiy extends StatelessWidget {
  final List swiperDateList;

  // 构造方法
  WpiperDiy(this.swiperDateList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network("${swiperDateList[index]['image']}",fit: BoxFit.fill,);
        },
        itemCount: swiperDateList.length,
        pagination: new SwiperPagination(),
        autoplay: true, // 自动播放
      ),
    );
  }
}
