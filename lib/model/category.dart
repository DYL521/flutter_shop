import '';

class CategoryBigModel {
  String mallCategoryId; // 类比编号
  String mallCategoryName; // 类别名称

  List<dynamic> bxMallSubDto;

  Null commonts;
  String image;

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.commonts,
    this.image,
  });

  //工厂模式的构造方法
  // 使用就不用new方法了
  factory CategoryBigModel.fromJson(dynamic json) {
    return CategoryBigModel(
      mallCategoryId: json["mallCategoryId"],
      mallCategoryName: json["mallCategoryName"],
      bxMallSubDto: json["bxMallSubDto"],
      commonts: json["commonts"],
      image: json["image"],
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;

  CategoryBigListModel(this.data);

  // 返回一个list
  factory CategoryBigListModel.formJson(List json) {
    return CategoryBigListModel(
        json.map((i) => CategoryBigModel.fromJson(i)).toList());
  }
}
