import 'dart:convert';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

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

            // 位置
            List<Map> navgatorList =
                (data['data']['category'] as List).cast(); // 解析成List

            // 广告
            String adPicture =
                data['data']["advertesPicture"]['PiCTURE_ADDRESS'];

            // 拨打店长电话
            String leadImage = data['data']["shopinfo"]['leadImage'];
            String leadPhone = data['data']["shopinfo"]['leadPhone'];

            return Column(
              children: <Widget>[
                WpiperDiy(swiperDataList),
                TopNavigator(navgatorList),
                AdBanner(adPicture),
                LeaderPhone(leadImage, leadPhone),
              ],
            );
          } else {
            //没有数据
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
    // 旧版本的， 写完之后再更新新版本 - 一般放全局
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
//      ..init(context); //iphone6 像素值

    // 输出屏幕像素密度
    print("设备的像素密度：${ScreenUtil.pixelRatio}");
    print("设备的宽：${ScreenUtil.screenWidth}");
    print("设备的高：${ScreenUtil.screenHeight}");
    return Container(
      height: ScreenUtil().scaleHeight(333),
      width: ScreenUtil().scaleWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: new SwiperPagination(),
        autoplay: true, // 自动播放
      ),
    );
  }
}

// 导航GridView
class TopNavigator extends StatelessWidget {
  final List navigigatorList;

  TopNavigator(this.navigigatorList);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击来导航～～～");
      },
      child: Column(
        children: [
          Image.network(
            item["image"],
            width: ScreenUtil().setWidth(90),
          ),
          Text(item["mallCategoryName"]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 删除后台数据给我们的多余的数据，不需要
    if (this.navigigatorList.length > 10) {
//      this.navigigatorList.removeLast();
      this.navigigatorList.removeRange(10, this.navigigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5, // 一行5个
        padding: EdgeInsets.all(5.0),
        children: navigigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

/**
 *  1、轮播组件        https://github.com/best-flutter/flutter_swiper/blob/master/README-ZH.md
 *  2、屏幕各种尺寸适配 https://github.com/OpenFlutter/flutter_screenutil
 *  3、拨打店长电话    github地址：https://github.com/flutter/plugins/tree/master/packages/url_launcher
 */

// 广告位置
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner(this.adPicture);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

// 拨打店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长头像
  final String leaderPhone; // 店长电话

  LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _laucherURL, // 单击事件
        child: Image.network(leaderImage),
      ),
    );
  }

  void _laucherURL() async {
    String url = "tel:" + leaderPhone;
    if (await canLaunch(url)) {
      // 异步方法
      await launch(url);
    } else {}
    throw ("不能进行拨打电话～～");
  }
}
