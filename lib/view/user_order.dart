import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/services/order_service.dart';



class UserOrder extends ConsumerWidget {
  const UserOrder({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final orderData = ref.watch(getOrderByUser(auth.user!.token));
    return Scaffold(
        body:SafeArea(
          child: orderData.when(
              data: (data){
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpansionTile(
                                title: Text(data[index].orderId,
                                ),
                              children: data[index].orderItems.map((e){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Image.network('${Api.baseUrl}${e.image}')),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(e.name),
                                              gapH10,
                                              Text('X ${e.qty}')
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text('Total Rs. ${data[index].totalPrice}'))

                                  ],
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      );
                    }
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: (){
            return Center(child: CircularProgressIndicator());
          }),
        )
    );
  }
}
