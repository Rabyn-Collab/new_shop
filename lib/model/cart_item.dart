import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  String product_name;

  @HiveField(1)
  String product_image;

  @HiveField(2)
  int qty;

  @HiveField(3)
  int price;

  @HiveField(4)
  String id;

  @HiveField(5)
  int stock;

  CartItem(
      {required this.product_name,
      required this.product_image,
      required this.price,
      required this.qty,
      required this.id,
      required this.stock});

  Map<String, dynamic> toJson() {
    return {
      'name': this.product_name,
      'qty': this.qty,
      'image': this.product_image,
      'price': this.price,
      'product': this.id
    };
  }
}
