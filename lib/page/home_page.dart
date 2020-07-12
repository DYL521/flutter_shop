
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


 // https://www.jspang.com/detailed?id=53

// easyMock

class HomePage extends StatelessWidget {
  
  
  
  @override
  Widget build(BuildContext context) {

    getHttp();
    return Scaffold(
      body: Center(
        child: Text("HomePage.dart"),
      ),
    );
  }
  
  
  void getHttp() async {
    try{
      Response response;
      
      response = await Dio().get("https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian?name=大熊美女");

      return print(response);
      
    }
    catch(e){
      return print(e);
    }
  }
}


