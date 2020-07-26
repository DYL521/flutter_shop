//  状态管理
// 混入ChangeNotifier
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮的索引

  String categoryId = "4"; // 默认大类id 4

  String subId = ""; // 小类id

  getChildCategory(List<BxMallSubDto> list, String id) {
    // 每次点击大类，索引都要归零,到全部的位置
    childIndex = 0;
    //传递大类id
    categoryId = id;

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

  // 改变子类索引
  /**
   * id 子类id
   */
  changeChildIndex(index,String id) {
    subId = id;
    childIndex = index;
    notifyListeners();
  }
}
