import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/provider/common_provider.dart';
import 'package:flutternew/services/crud_service.dart';
import 'package:get/get.dart';

import '../provider/crud_provider.dart';


class CreatePage extends ConsumerStatefulWidget {

  @override
  ConsumerState<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  final nameController = TextEditingController();
  final  detailController = TextEditingController();
  final  priceController = TextEditingController();
  final  stockController = TextEditingController();
  String brand = 'Nike';
  String category = 'Sports';


  final items = [
    'Nike',
    'Sunsilk',
    'Levis',
    'Bmw',
  ];
  final items1 = [
    'Sports',
    'Tech',
    'Toys',
    'Clothes',
  ];

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(crudProvider, (previous, next) {
      if(next.isError){
        SnackShow.showFailure(context,next.errText);
      }else if(next.isSuccess){
        ref.invalidate(getProducts);
        SnackShow.showSuccess(context, 'success');
        Get.back();
      }

    });

     final crud = ref.watch(crudProvider);
     final auth = ref.watch(authProvider);
    final image = ref.watch(imageProvider);
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    gapH20,
                    TextFormField(
                      controller: nameController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Title',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: detailController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide your detail';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Detail',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: priceController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'price',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: stockController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide stock';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Stock',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    DropdownButton(
                       value: brand,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      itemHeight: 50,
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          brand = newValue!;
                        });
                      },
                    ),

                    gapH20,
                    DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      itemHeight: 50,
                      items: items1.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),

                    gapH20,
                    InkWell(
                      onTap: (){
                        ref.read(imageProvider.notifier).pickUImage(false);
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)
                        ),
                        child: image == null ? Center(child: Text('Please select an image'))
                            : Image.file(File(image.path), fit: BoxFit.cover,),
                      ),
                    ),
                    gapH20,


                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5)
                        ),
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                          _form.currentState!.save();
                          if(_form.currentState!.validate()){


                            if(image == null){
                              SnackShow.showFailure(context,'no images selected');
                            }else{
                              ref.read(crudProvider.notifier).addProduct(
                                  product_name: nameController.text.trim(),
                                  product_detail: detailController.text.trim(),
                                  product_price:int.parse(priceController.text.trim()),
                                  brand: brand,
                                  category: category,
                                  countInStock: int.parse(stockController.text.trim()),
                                  image: image,
                                  token: auth.user!.token
                              );

                            }


                          }
                        },
                        child: crud.isLoad ? Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        )):
                        Text('Submit')),

                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}