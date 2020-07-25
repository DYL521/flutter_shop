import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("分类页面"),
      ),
    );
  }

  // 接口测试
  void __getCategory() async {
    await request("getCategory").then((value) {
      var data = json.decode(value.toString());
      CategoryBigListModel list = CategoryBigListModel.formJson(data["data"]);

      list.data.forEach((element) {
        print("element");
      });
    });
  }
}
