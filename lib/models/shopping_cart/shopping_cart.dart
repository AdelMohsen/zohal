import 'package:zohal/models/products/new_items.dart';

class ShoppingCart {
  int? success;
  ShoppingCartData? shoppingCartData;
  ShoppingCart.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    shoppingCartData =
        json['data'] != null ? ShoppingCartData.fromJson(json['data']) : null;
  }
}

class ShoppingCartData {
  int? totalPrice;
  List<CartDetails>? cart;

  ShoppingCartData.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    cart = (json['cart'] as List).map((e) => CartDetails.fromJson(e)).toList();
  }
}

class CartDetails {
  Decoration? decoration;
  Product? product;
  String? quantity;
  String? discountPrice;
  String? price;
  CartDetails.fromJson(Map<String, dynamic> json) {
    decoration = Decoration.fromJson(json['decorations']);
    product = Product.fromJson(json['product']);
    quantity = json['quantity'];
    discountPrice = json['discountPrice'];
    price = json['price'];
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

class Product {
  String? productId;
  String? productName;
  String? productModel;
  Product.fromJson(Map<String, dynamic> json) {
    productId = json['_id'];
    productName = json['name'];
    productModel = json['model'];
  }
}
