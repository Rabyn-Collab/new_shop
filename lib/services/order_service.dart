import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/order.dart';


import '../api.dart';
import '../api_execption.dart';


final getOrderByUser = FutureProvider.family((ref, String token) => OrderService.getOrderByUser(token));
final getAllOrder = FutureProvider.family((ref, String token) => OrderService.getAllOrder(token));

class OrderService {


  static final dio = Dio();

  static Future<List<Orders>> getOrderByUser(String token) async{
    try{
      final response = await dio.get(Api.getOrder, options: Options(
          headers: {
            HttpHeaders.authorizationHeader:  token
          }
      ));
      return (response.data as List).map((e) => Orders.fromJson(e)).toList();
    }on DioError catch (err){
      throw DioException.getErrorText(err);
    }
  }

  static Future<List<Orders>> getAllOrder(String token) async{
    try{
      final response = await dio.get(Api.getAllOrder, options: Options(
          headers: {
            HttpHeaders.authorizationHeader:  token
          }
      ));
      return (response.data as List).map((e) => Orders.fromJson(e)).toList();
    }on DioError catch (err){
      throw DioException.getErrorText(err);
    }
  }




  static Future<Either<String, bool>> addOrder({
   required List<Map> orderItems,
   required int totalPrice,
    required String token
  }) async{
    try{

      final response = await dio.post(Api.createOrder, data: {
        'orderItems': orderItems,
        'totalPrice': totalPrice
      }, options: Options(
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
