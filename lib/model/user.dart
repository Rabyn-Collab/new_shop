

class Shipping{
  final String address;
  final String city;
  final bool isEmpty;

  Shipping({
    required this.isEmpty,
    required this.address,
    required this.city
});

  factory Shipping.fromJson(Map<String, dynamic> json){
    return Shipping(
        isEmpty: json['isEmpty'],
        address: json['address'],
        city: json['city']
    );
  }

}


class User{

  final String token;
  final String email;
  final String fullname;
  final bool isAdmin;
  final Shipping shipping;

  User({
    required this.shipping,
    required this.fullname,
    required this.email,
    required this.token,
    required this.isAdmin
});


  factory User.fromJson(Map<String, dynamic> json){
    return User(
        shipping: Shipping.fromJson(json['shippingAddress']),
        fullname: json['fullname'],
        email: json['email'],
        token: json['token'],
        isAdmin: json['isAdmin']
    );
  }

  factory User.empty(){
    return User(
        shipping: Shipping(
            isEmpty: true,
            address: '',
            city: ''
        ),
        fullname: '',
        email: '',
        token: '',
        isAdmin: false
    );
  }


}