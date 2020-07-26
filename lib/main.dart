import 'package:flutter/material.dart'; // material 风格
import 'package:flutter_shop/page/index_page.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/provider/counter.dart';
import 'package:provide/provide.dart';


void main() {
  var counter = Counter();
  var providers = Providers();
  var childCategroy = ChildCategory();

  // 状态管理
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategroy));
  runApp(ProviderNode(child: MyApp(),providers: providers,));
}

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







