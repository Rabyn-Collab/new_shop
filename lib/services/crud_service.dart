import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/product.dart';
import 'package:image_picker/image_picker.dart';

import '../api.dart';
import '../api_execption.dart';


final getProducts = FutureProvider((ref) => CrudService.getProducts());

class CrudService {


static final dio = Dio();

static Future<List<Product>> getProducts() async{
   try{
     final response = await dio.get(Api.baseUrl);
     return (response.data as List).map((e) => Product.fromJson(e)).toList();
   }on DioError catch (err){
     throw DioException.getErrorText(err);
   }
}

static Future<Either<String, bool>> addProduct({
  required String product_name,
  required String product_detail,
  required int  product_price,
  required String brand,
  required String  category,
  required int countInStock,
  required XFile image,
  required String token
}) async{
  try{
    final formData = FormData.fromMap({
      'product_image': await MultipartFile.fromFile(image.path, filename: image.name),
      'product_name': product_name,
      'product_detail': product_detail,
      'product_price': product_price,
      'brand': brand,
      'category': category,
      'countInStock': countInStock
    });
    final response = await dio.post(Api.productAdd, data: formData, options: Options(
      headers: {
        HttpHeaders.authorizationHeader:  token
      }
    ));
    return Right(true);
  }on DioError catch (err){
    return Left(DioException.getErrorText(err));
  }
}


static Future<Either<String, bool>> updateProduct({
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
  try{

    if(image == null){
      final response = await dio.patch('${Api.productUpdate}/$productId', data: {
        'product_name': product_name,
        'product_detail': product_detail,
        'product_price': product_price,
        'brand': brand,
        'category': category,
        'countInStock': countInStock
      }, options: Options(
          headers: {
            HttpHeaders.authorizationHeader:  token
          }
      ));
      return Right(true);
    }else{
      final formData = FormData.fromMap({
        'product_image': await MultipartFile.fromFile(image.path, filename: image.name),
        'product_name': product_name,
        'product_detail': product_detail,
        'product_price': product_price,
        'brand': brand,
        'category': category,
        'countInStock': countInStock
      });
      final response = await dio.patch('${Api.productUpdate}/$productId', data: formData,
          queryParameters: {
        'imagePath': imagePath
          },
          options: Options(
          headers: {
            HttpHeaders.authorizationHeader:  token
          }
      ));
      return Right(true);

    }

  }on DioError catch (err){
    return Left(DioException.getErrorText(err));
  }
}


static Future<Either<String, bool>> removeProduct({
  required String imagePath,
  required String id,
  required String token
}) async{
  try{
    final response = await dio.delete('${Api.productUpdate}/$id',  queryParameters: {
      'imagePath': imagePath
    },
        options: Options(
            headers: {
              HttpHeaders.authorizationHeader:  token
            }
        ));
    return Right(true);
  }on DioError catch (err){
    return Left(DioException.getErrorText(err));
  }
}




}
