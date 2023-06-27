class Product {
  final String product_name;
  final String product_detail;
  final int product_price;
  final String id;
  final int rating;
  final int numReviews;
  final String product_image;
  final String brand;
  final String category;
  final int countInStock;

  Product(
      {required this.brand,
      required this.category,
      required this.countInStock,
      required this.id,
      required this.numReviews,
      required this.product_detail,
      required this.product_image,
      required this.product_name,
      required this.product_price,
      required this.rating});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        brand: json['brand'],
        category: json['category'],
        countInStock: json['countInStock'],
        id: json['_id'],
        numReviews: json['numReviews'],
        product_detail: json['product_detail'],
        product_image: json['product_image'],
        product_name: json['product_name'],
        product_price: json['product_price'],
        rating: json['rating']
    );
  }


}
