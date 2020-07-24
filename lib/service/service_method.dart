import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

// 开始获取数据

Future request(url, {formData}) async {
  try {
    print("开始获取数据.....");
    Response response;
    Dio dio = new Dio();

//  dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded") as String;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == "200") {
      return response.data;
    } else {
      throw Exception("后端接口异常～");
    }
  } catch (e) {
    return print("========: 错误");
  }
}

Future getHomePageContent() async {
  try {
    print("开始获取首页数据");
    Response response;
    Dio dio = new Dio();

//  dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded") as String;

    var formData = {'lon': '115.02932', "lat": '35.76189'};
    response = await dio.post(servicePath["homePageContent"], data: formData);

    if (response.statusCode == "200") {
      return response.data;
    } else {
      throw Exception("后端接口异常～");
    }
  } catch (e) {
    return print("========: 错误");
  }
}

// 获得火爆专区的数据
Future getHomePageBeloContent() async {
  try {
    print("开始获得火爆专区的数据....");
    Response response;
    Dio dio = new Dio();
//  dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded") as String;

    // 分页
    int page = 1;
    response = await dio.post(servicePath["homePageBelowConten"], data: page);

    if (response.statusCode == "200") {
      return response.data;
    } else {
      throw Exception("后端接口异常～");
    }
  } catch (e) {
    return print("========: 错误");
  }
}
