import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeards.dart';

// https://www.jspang.com/detailed?id=53

// easyMock

class HomePage extends StatefulWidget {
 _HomePageState createState() => _HomePageState();
}





class _HomePageState extends State<HomePage>{

  String showText = "还没有请求数据";

  @override
  Widget build(BuildContext context) {
//    __jike();
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("请求远程数据"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: __jike,
                child: Text("请求数据"),
              ),
              Text(showText),
            ],
          ),
        ),
      ),
    );
  }

  void __jike(){
    print("开始请求数据～～～");
    //  Http status error [451]  非法请求～ 服务器拒绝
    getHttp().then((val){
      setState(() {
        showText = val["data"].toString();
      });
    });
  }

  Future getHttp() async {

    try {
      Response response;
      Dio dio = new Dio();
      dio.options.headers = httpHeaders;
      response = await dio.get("https://time.geekbang.org/serv/v3/lecture/list");
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
