import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/provider/cart_provider.dart';
import 'package:flutternew/services/crud_service.dart';
import 'package:flutternew/view/cart_page.dart';
import 'package:flutternew/view/detail_page.dart';
import 'package:flutternew/view/product_list.dart';
import 'package:flutternew/view/user_order.dart';
import 'package:get/get.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final userData = ref.watch(authProvider);
        final productData = ref.watch(getProducts);
        return Scaffold(
          appBar: AppBar(
            title: Text('Sample Shop'),
            actions: [
              IconButton(onPressed: (){
                Get.to(() => CartPage());
              }, icon: Icon(Icons.shopping_cart_checkout_outlined))
            ],
          ),
            drawer: Drawer(
              child: ListView(
               children: [
               if(userData.user!.isAdmin)  ListTile(
                   onTap: (){
                     Navigator.of(context).pop();
                     Get.to(() => ProductList());
                   },
                   leading: Icon(Icons.add),
                   title: Text('Customize Product'),
                 ),
                ListTile(
                   onTap: (){
                     if(userData.user!.isAdmin){

                     }else{
                       Navigator.of(context).pop();
                       Get.to(() => UserOrder());
                     }

                   },
                   leading: Icon(Icons.add),
                   title: Text('order history'),
                 ),
                 ListTile(
                   onTap: (){
                     Navigator.of(context).pop();
                     ref.read(cartProvider.notifier).clear();
                     ref.read(authProvider.notifier).userLogOut();

                   },
                   leading: Icon(Icons.exit_to_app),
                   title: Text('Sign Out'),
                 )
               ],
              ),
            ),
            body: SafeArea(
                child: productData.when(
                    data: (data){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          itemCount: data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              childAspectRatio: 2/3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5
                            ),
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.to(() => DetailPage(data[index]));
                                },
                                child: GridTile(
                                    child: Hero(
                                        tag: data[index].id,
                                        child: Image.network('${Api.baseUrl}${data[index].product_image}', fit: BoxFit.cover,)),
                                  footer: Container(
                                    height: 50,
                                    color: Colors.black87,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data[index].product_name),
                                          Text('Rs. ${data[index].product_price}')
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => Center(child: CircularProgressIndicator())
                )
            )
        );
      }
    );
  }
}
