import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/category.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategroyNav(),
                // 测试数据
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    __getCategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _leftInWell(index);
          },
        ));
  }

  // 单个子项目的封装
  Widget _leftInWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });

        // 子类信息
        var childList = list[index].bxMallSubDto; // 左侧的大类 -联动

        // 改变子类状态 -> 传入子类
        Provide.value<ChildCategory>(context).getChildCategory(childList);

        //点击大类,的id
        var categoryId = list[index].mallCategoryId;
        // 根据ID请求数据
        _getGoodsList(categroyId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            //点击效果
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            //  isClick  被点击，显示颜色深的否则默认白色
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  // 接口测试
  void __getCategory() async {
    await request("getCategory").then((value) {
      var data = json.decode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      // 拿到数据之后，直接传递第一个数据给界面 - 默认显示
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto);
    });
  }

  // 右侧的数据，跟左侧有联动的效果，送放在这里
  void _getGoodsList({String categroyId}) async {
    var data = {
      "categoryId": categroyId == null ? "4" : categroyId,
      "CategorySubId": "",
      "page": 1
    };

    await request("getMallGoods", formData: data).then((value) {
      var data = json.decode(value.toString());
      print("分类商品列表： >>>> ${data}");
      // 直接转换成对象
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);

      // 状态管理的形式处理数据
      Provide.value<CategoryGoodslistProvide>(context)
          .getGoodsList(goodsList.data);

//      setState(() {
//        list = goodsList.data;
//      });
    });
  }
}

// 右侧导航栏
class RightCategroyNav extends StatelessWidget {
//  List list = ["名酒", "宝丰", "北京二锅头","茅台"];

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInWell(childCategory.childCategoryList[index]);
            },
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }

  // 单个wight
  Widget _rightInWell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10, 5.0, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

// 商品列表，上拉加载更多
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
//  List list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodslistProvide>(
      builder: (context, child, data) {
        // data 是状态管理的数据
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(1000),
          child: ListView.builder(
              itemCount: data.goodsList.length,
              itemBuilder: (context, index) {
                return _ListWidget(data.goodsList, index);
              }),
        );
      },
    );
  }

  Widget _goodImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
    );
  }

  Widget _goodsPrice(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: <Widget>[
          Text(
            "价格：${newList[index].presentPrice}",
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            "价格：${newList[index].oriPrice}",
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(30),
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  // 组装成一个Widget
  Widget _ListWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.black12)),
        ),
        child: Row(
          children: <Widget>[
            _goodImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
