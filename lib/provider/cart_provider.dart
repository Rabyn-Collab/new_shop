import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/main.dart';
import 'package:flutternew/model/cart_item.dart';
import 'package:flutternew/model/product.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';


final cartProvider = StateNotifierProvider<CartProvider, List<CartItem>>((ref) => CartProvider(ref.watch(cartBox)));

class CartProvider extends StateNotifier<List<CartItem>>{
  CartProvider(super.state);


  void addToCart(Product product, BuildContext context){
    final newCart = CartItem(
        product_name: product.product_name,
        product_image: product.product_image,
        price: product.product_price,
        qty: 1,
        stock: product.countInStock,
        id: product.id
    );
      if(state.isEmpty){
        state.add(newCart);
        Hive.box<CartItem>('carts').add(newCart);
        SnackShow.shopShow(context, 'successfully added to cart');
      }else{
         final isExist = state.firstWhereOrNull((cart) => cart.id == product.id);
         if(isExist == null){
           state.add(newCart);
           Hive.box<CartItem>('carts').add(newCart);
           SnackShow.shopShow(context, 'successfully added to cart');
         }else{
           SnackShow.shopShow(context, 'already added to cart');

         }

      }
  }
  void singleAdd(CartItem cartItem, BuildContext context){
    if( cartItem.qty < cartItem.stock){
      cartItem.qty = cartItem.qty + 1;
      cartItem.save();
      state = [
        for(final c in state) c.id == cartItem.id ? cartItem : c
      ];
    }else{
      SnackShow.showFailure(context, 'out of stock');
    }

  }

  void singleRemove(CartItem cartItem){
    if(cartItem.qty > 1){
      cartItem.qty = cartItem.qty - 1;
      cartItem.save();
      state = [
        for(final c in state) c.id == cartItem.id ? cartItem : c
      ];
    }

  }

  void remove(CartItem cartItem){
    cartItem.delete();
    state.remove(cartItem);
    state = [...state];
  }


  int get total{
   int total = 0;
   for(final n in state){
     total += n.qty * n.price;
   }
   return total;
  }


  void clear (){
    state = [];
    Hive.box<CartItem>('carts').clear();
  }

}