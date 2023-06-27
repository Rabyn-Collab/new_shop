



class Orders{
final String user;
final List<OrderItem> orderItems;
final int totalPrice;
final String orderId;

Orders({
  required this.user,
  required this.orderId,
  required this.orderItems,
  required this.totalPrice
});

factory Orders.fromJson(Map<String, dynamic> json){
  return Orders(
      user: json['user'],
      orderId: json['_id'],
      orderItems: (json['orderItems'] as List).map((e) => OrderItem.fromJson(e)).toList(),
      totalPrice: json['totalPrice']
  );
}

}



class OrderItem{
  final String name;
  final int qty;
  final String image;
  final String product;
  final String itemId;

  OrderItem({
    required this.qty,
    required this.product,
    required this.image,
    required this.name,
    required this.itemId
});

  factory OrderItem.fromJson(Map<String, dynamic> json){
    return OrderItem(
        qty: json['qty'],
        product: json['product'],
        image: json['image'],
        name: json['name'],
        itemId: json['_id']
    );
  }

}