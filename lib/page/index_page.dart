import 'package:flutter/cupertino.dart'; // cupertino 风格
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/page/cart_page.dart';
import 'package:flutter_shop/page/category_page.dart';
import 'package:flutter_shop/page/home_page.dart3';
import 'package:flutter_shop/page/member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
  ];

  final List<Widget> tabbodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  int currentIndex = 0; //当前的页面索引
  var currentPage; //当前的页面

  @override
  void initState() {
    // TODO: implement initState
    currentPage = tabbodies[currentIndex]; // 默认首页

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //初始化的是一般放在全局的位置
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context); //iphone6 像素值
    return Container(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //fixed  、shifting类型
        currentIndex: currentIndex, // 索引
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabbodies[index]; // 找到真实的页面
          });
        },
      ),

      body: IndexedStack(
          index: currentIndex, // IndexedStack 页面状态
          children: tabbodies),
//        currentPage, // 当前页面的显示
    ));
  }
}
