import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String homePageContent  = "正在获取数据";


  @override
  void initState() {
    // TODO: implement initState
    // 获取主页数据
    getHomePageContent().then((val){
      setState(() {
        homePageContent = val.toString();
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("百姓生活家"),),
      body: SingleChildScrollView(
      child: Text(homePageContent),
      ),
    );
  }
}
