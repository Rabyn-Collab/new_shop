import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/common_state.dart';
import 'package:flutternew/services/order_service.dart';



final orderProvider = StateNotifierProvider<OrderProvider,CommonState>((ref) => OrderProvider(
    CommonState(
        isLoad: false,
        isSuccess: false,
        isError: false,
        errText: ''
    )));

class OrderProvider extends StateNotifier<CommonState>{
  OrderProvider(super.state);


   Future<void> addOrder({
    required List<Map> orderItems,
    required int totalPrice,
    required String token
  }) async{
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await OrderService.addOrder(orderItems: orderItems, totalPrice: totalPrice, token: token);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
    });

  }

}