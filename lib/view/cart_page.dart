import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/provider/order_provider.dart';
import 'package:get/get.dart';

import '../provider/cart_provider.dart';
import 'shipping_page.dart';



class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartData = ref.watch(cartProvider);
   final total = ref.watch(cartProvider.notifier).total;
   final auth = ref.watch(authProvider);
    final crud = ref.watch(orderProvider);
    ref.listen(orderProvider, (previous, next) {
      if(next.isError){
        SnackShow.showFailure(context,next.errText);
      }else if(next.isSuccess){
        ref.read(cartProvider.notifier).clear();
        SnackShow.showSuccess(context, 'success');
        Get.back();
      }

    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
        body: cartData.isEmpty ? Center(child: Text('Add something to cart')) : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      child: Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              errorWidget: (c, s ,d) =>Center(child: CircularProgressIndicator()),
                              imageUrl:'${Api.baseUrl}${cartData[index].product_image}', fit: BoxFit.fitHeight,),
                          ),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                ref.read(cartProvider.notifier).remove(cartData[index]);
                              }, icon: Icon(Icons.close)),
                              Text(cartData[index].product_name),
                              Text('Rs. ${cartData[index].price}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(onPressed: (){
                                    ref.read(cartProvider.notifier).singleAdd(cartData[index], context);
                                  }, child: Icon(Icons.add)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(cartData[index].qty.toString()),
                                  ),
                                  OutlinedButton(onPressed: (){
                                    ref.read(cartProvider.notifier).singleRemove(cartData[index]);
                                  }, child: Icon(Icons.remove)),
                                ],
                              )
                            ],
                          )),

                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:-'),
                      Text(total.toString(), style: TextStyle(fontSize: 17),),
                    ],
                  ),
                  gapH10,
                  ElevatedButton(
                      onPressed: (){
                    if(auth.user!.shipping.isEmpty){
                      Get.to(() => ShippingPage());
                    }else{
                      ref.read(orderProvider.notifier).addOrder(
                          orderItems: cartData.map((e) => e.toJson()).toList(),
                          totalPrice: total,
                          token: auth.user!.token
                      );

                    }
                  }, child: crud.isLoad ? Center(child: CircularProgressIndicator()) :Text('place order'))
                ],
              )
            ],
          ),
        )
    );
  }
}
