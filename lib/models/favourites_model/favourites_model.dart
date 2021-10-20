class FavouritesModel {
  int? success;
  List<FavouritesItemData> favouritesItemData = [];

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    favouritesItemData = json['data'] != []
        ? (json['data'] as List)
            .map((e) => FavouritesItemData.fromJson(e))
            .toList()
        : [];
  }
}

class FavouritesItemData {
  String? addedAt;
  Product? product;

  FavouritesItemData.fromJson(Map<String, dynamic> json) {
    addedAt = json['addedAt'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  String? id;
  String? name;
  String? model;
  String? price;
  String? discountPrice;
  List<Decoration>? decoration;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    decoration = (json['decorations'] as List)
        .map((e) => Decoration.fromJson(e))
        .toList();
  }
}

class Decoration {
  String? color;
  String? imgUrl1;
  String? imgUrl2;
  String? imgUrl3;
  String? imgUrl4;
  String? id;

  Decoration.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    imgUrl1 = json['image1Url'];
    imgUrl2 = json['image2Url'];
    imgUrl3 = json['image3Url'];
    imgUrl4 = json['image4Url'];
    id = json['_id'];
  }
}
