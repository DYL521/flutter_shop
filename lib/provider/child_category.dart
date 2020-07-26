//  状态管理
// 混入ChangeNotifier
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List list) {
    childCategoryList = list;
    notifyListeners(); // 监听
  }



}
