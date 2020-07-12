import 'package:flutter/material.dart';   // material 风格
//import 'package:flutter/cupertino.dart'; //cupertino
import 'package:flutter_shop/page/index_page.dart';



void  main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(

        title: "百姓生活+",
        debugShowCheckedModeBanner: false, // 不显示debug
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),

    ); // Container 扩展就很容易


  }
}







