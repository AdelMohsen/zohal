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
  Decoration? decoration;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    model = json['model'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    decoration = Decoration.fromJson(json['decorations']);
  }
}

class Decoration {
  String? color;
  String? indexPhotoUrl;

  Decoration.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    indexPhotoUrl = json['indexPhotoUrl'];
  }
}
