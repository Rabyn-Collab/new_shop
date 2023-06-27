import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/provider/crud_provider.dart';
import 'package:flutternew/view/create_page.dart';
import 'package:flutternew/view/update_page.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/crud_service.dart';



class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Crud'),
        actions: [
          TextButton(
              onPressed: (){
                Get.to(() => CreatePage());
              },
              child: Text('Add Product'))
        ],
      ),
        body: Consumer(
            builder: (context, ref, child) {
              final productData = ref.watch(getProducts);
              final auth = ref.watch(authProvider);

              return SafeArea(
                  child:  productData.when(
                      data: (data){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index){
                                return ListTile(
                                  leading: Image.network('${Api.baseUrl}${data[index].product_image}', fit: BoxFit.cover,),
                                  title:    Text(data[index].product_name),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       IconButton(onPressed: (){
                                         Get.to(()=> UpdatePage(data[index]));
                                       }, icon: Icon(Icons.edit)),
                                       IconButton(onPressed: (){
                                         Get.defaultDialog(
                                           title: 'Hold On',
                                           content: Text('Are you sure remove this product'),
                                           actions: [
                                             TextButton(onPressed: (){
                                               Navigator.of(context).pop();
                                               ref.read(crudProvider.notifier).removeProduct(
                                                   imagePath: data[index].product_image,
                                                   id: data[index].id,
                                                   token: auth.user!.token
                                               );
                                             }, child: Text('Yes')),
                                             TextButton(onPressed: (){
                                               Navigator.of(context).pop();
                                             }, child: Text('No')),
                                           ]
                                         );
                                       }, icon: Icon(Icons.delete)),
                                      ],
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
              );
            }
    )
    );
  }
}
