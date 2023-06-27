import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/common_state.dart';
import 'package:flutternew/services/crud_service.dart';
import 'package:image_picker/image_picker.dart';



final crudProvider = StateNotifierProvider<CrudProvider,CommonState>((ref) => CrudProvider(
    CommonState(
        isLoad: false,
        isSuccess: false,
        isError: false,
        errText: ''
    )));

class CrudProvider extends StateNotifier<CommonState>{
  CrudProvider(super.state);



  Future<void> addProduct({
    required String product_name,
    required String product_detail,
    required int  product_price,
    required String brand,
    required String  category,
    required int countInStock,
    required XFile image,
    required String token
  }) async{
   state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
   final response = await CrudService.addProduct(
       product_name: product_name,
       product_detail: product_detail,
       product_price: product_price,
       brand: brand,
       category: category,
       countInStock: countInStock,
       image: image, token: token
   );
   response.fold((l) {
     state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
   }, (r) {
     state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
   });

  }


   Future<void> updateProduct({
    required String product_name,
    required String product_detail,
    required int  product_price,
    required String brand,
    required String  category,
    required int countInStock,
    XFile? image,
    String? imagePath,
    required String token,
    required String productId
  }) async{
     state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
     final response = await CrudService.updateProduct(
         product_name: product_name,
         product_detail: product_detail,
         product_price: product_price,
         brand: brand,
          imagePath: imagePath,
         image: image,
         category: category, countInStock: countInStock, token: token, productId: productId);
     response.fold((l) {
       state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
     }, (r) {
       state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
     });
  }





 Future<void> removeProduct({
    required String imagePath,
    required String id,
    required String token
  }) async{
   state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
   final response = await CrudService.removeProduct(imagePath: imagePath, id: id, token: token);
   response.fold((l) {
     state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
   }, (r) {
     state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
   });
 }


}