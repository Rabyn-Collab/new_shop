import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutternew/api.dart';
import 'package:flutternew/api_execption.dart';
import 'package:hive/hive.dart';

import '../model/user.dart';




class AuthService {


static  final dio = Dio();



static  Future<Either<String, User>> userLogin(
      {required String email, required String password}) async {
    try {
        final response = await dio.post(Api.userLogin, data: {
          'email': email,
          'password': password
        });

        final userBox = Hive.box<String?>('user');
        userBox.put('userData', jsonEncode(response.data['user']));
      return Right(User.fromJson(response.data['user']));

    } on DioError catch (err) {
      return Left(DioException.getErrorText(err));
    }on HiveError catch(err){
      return Left(err.message);
    }
  }


static  Future<Either<String, bool>> userSignUp(
    {
      required String email,
      required String password,
      required String fullname,
    }) async {
  try {
    final response = await dio.post(Api.userSignUp, data: {
      'email': email,
      'password': password,
      'fullname': fullname
    });
    return Right(true);
  } on DioError catch (err) {
    return Left(DioException.getErrorText(err));
  }
}


static  Future<Either<String, bool>> userUpdate(
    {
      required String address,
      required String city,
      required String token,
    }) async {
  try {
    final response = await dio.patch(Api.userUpdate, data: {
      'shippingAddress': {
        'address': address,
        'city': city
      },
    },
        options: Options(
            headers: {
              HttpHeaders.authorizationHeader:  token
            }
        )
    );
    return Right(true);
  } on DioError catch (err) {
    return Left(DioException.getErrorText(err));
  }
}




}
