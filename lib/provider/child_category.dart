//  状态管理
// 混入ChangeNotifier
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  getChildCategory(List<BxMallSubDto> list) {

    // 添加全部 - all
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = "00";
    all.mallCategoryId = "00";
    all.comments = "null";
    all.mallSubName = "全部";
    childCategoryList = [all];

    childCategoryList.addAll(list);
    notifyListeners(); // 监听
  }



}
