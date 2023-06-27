import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/model/product.dart';
import 'package:flutternew/provider/cart_provider.dart';


class DetailPage extends StatelessWidget {

  final Product product;
  DetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
           Container(
             width: double.infinity,
             margin: EdgeInsets.only(top: 200),
             padding: EdgeInsets.only(top: 100),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))

             ),
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   Expanded(child: Text(product.product_detail, style: TextStyle(color: Colors.black),)),
                   Consumer(
                     builder: (context, ref, child) {
                       return Padding(
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         child: ElevatedButton(
                             onPressed: () {
                               ref.read(cartProvider.notifier).addToCart(product, context);
                             }, child: Text('Add To Cart')),
                       );
                     }
                   ),
                 ],
               ),
             ),
           ),
              Container(
                height: 275,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gapH20,
                          Expanded(child: Text(product.product_name)),
                          Expanded(child: Text('Rs.${product.product_price}'))
                        ],
                      ),
                    ),
                    SizedBox(width: 70,),
                    Expanded(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                                tag: product.id,
                                child: Image.network('${Api.baseUrl}${product.product_image}')))
                    ),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
