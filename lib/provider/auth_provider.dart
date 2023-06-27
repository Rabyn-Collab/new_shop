import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/model/common_state.dart';
import 'package:flutternew/model/user.dart';
import 'package:flutternew/services/auth_service.dart';
import 'package:hive/hive.dart';
import '../main.dart';



final authProvider = StateNotifierProvider<AuthProvider,CommonState>((ref) => AuthProvider(
    CommonState(
  isLoad: false,
  isSuccess: false,
  isError: false,
  errText: '',
        user: ref.watch(box)
)));

class AuthProvider extends StateNotifier<CommonState>{
  AuthProvider(super.state);


  Future<void> userLogin(
      {required String email, required String password}) async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userLogin(email: email, password: password);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: true, isLoad: false, user: r);
    });
  }

  Future<void> userSignUp(
      {
        required String email,
        required String password,
        required String fullname
      }) async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userSignUp(email: email, password: password, fullname: fullname);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false);
    });
  }

   Future<void> userUpdate(
      {
        required String address,
        required String city,
        required String token,
        required User user
      }) async {
    state = state.copyWith(errText: '',isError: false, isSuccess: false, isLoad: true);
    final response = await AuthService.userUpdate(address: address, city: city, token: token);
    response.fold((l) {
      state = state.copyWith(errText: l,isError: true, isSuccess: false, isLoad: false);
    }, (r) {
      state = state.copyWith(errText: '',isError: false, isSuccess: r, isLoad: false,  user: User(
          shipping: Shipping(
              isEmpty: false, address: address, city: city),
          fullname: user.fullname,
          email: user.email,
          token: token,
          isAdmin: user.isAdmin
      ));
    });
  }



  Future<void> userLogOut() async {
    final userBox = Hive.box<String?>('user');
    userBox.clear();
    state = state.copyWith(user: null);
  }





}