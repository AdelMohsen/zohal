class SearchModel {
  int? success;
  List<ItemsData> itemsData = [];

  SearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    itemsData = success != 0
        ? (json['data'] as List).map((e) => ItemsData.fromJson(e)).toList()
        : [];
  }
}

class BrandData {
  String? brandId;
  String? brandName;
  String? brandPhotoUrl;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? brand_V;

  BrandData.fromJson(Map<String, dynamic> json) {
    brandId = json['_id'];
    brandName = json['name'];
    brandPhotoUrl = json['photoUrl'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    brand_V = json['__v'];
  }
}

class ItemsData {
  String? id;
  String? name;
  String? model;
  SubSection? subSection;
  String? vendor;
  String? price;
  String? discountPrice;
  String? inStock;
  String? description;
  List? ratings;
  List<Decoration>? decoration;
  List? sizes;
  List? history;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? v;
  BrandData? brand;

  ItemsData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    model = json['model'];
    subSection = json['subSection'] != null
        ? SubSection.fromJson(json['subSection'])
        : null;
    vendor = json['vendor'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    inStock = json['inStock'];
    description = json['description'];
    for (var element in (json['ratings'] as List)) {
      ratings!.add(element);
    }
    decoration = (json['decorations'] as List)
        .map((e) => Decoration.fromJson(e))
        .toList();

    sizes = json['sizes'];
    history = json['history'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    brand = BrandData.fromJson(json['brand']);
  }
}

class SubSection {
  String? subSectionId;
  Categorires? categories;
  SubSection.fromJson(Map<String, dynamic> json) {
    subSectionId = json['_id'];
    categories = json['category'] != null
        ? Categorires.fromJson(json['category'])
        : null;
  }
}

class Categorires {
  String? categoriesId;
  String? categoriesName;
  Categorires.fromJson(Map<String, dynamic> json) {
    categoriesId = json['_id'];
    categoriesName = json['name'];
  }
}

class Decoration {
  String? color;
  String? img1Url;
  String? img2Url;
  String? img3Url;
  String? img4Url;
  String? decorationId;

  Decoration.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    img1Url = json['image1Url'];
    img2Url = json['image2Url'];
    img3Url = json['image3Url'];
    img4Url = json['image4Url'];
    decorationId = json['_id'];
  }
}
