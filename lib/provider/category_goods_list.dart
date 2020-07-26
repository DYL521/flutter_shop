//  状态管理
// 混入ChangeNotifier

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import '../model/category.dart';

class CategoryGoodslistProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  // 点击大类时，更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
     // 监听
    notifyListeners();
  }
}
