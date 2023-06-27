import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/model/cart_item.dart';
import 'package:flutternew/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/user.dart';



final box = Provider<User?>((ref) => null);
final cartBox = Provider<List<CartItem>>((ref) => []);

void main () async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await Hive.initFlutter();
Hive.registerAdapter(CartItemAdapter());

await Hive.openBox<String?>('user');
final cartData = await Hive.openBox<CartItem>('carts');

final userBox = Hive.box<String?>('user');
final userData = userBox.get('userData');
 runApp(
     ProviderScope(
       overrides: [
         box.overrideWithValue(userData == null ? null: User.fromJson(jsonDecode(userData))),
         cartBox.overrideWithValue(cartData.values.toList())
       ],
         child: Home()
     )
 );

}

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData.dark(),
   debugShowCheckedModeBanner: false,
   home: StatusPage(),
    );
  }
}

