


import 'package:flutternew/model/user.dart';

class CommonState{

  final String errText;
  final bool isError;
  final bool isSuccess;
  final bool isLoad;
  final User? user;

  CommonState({
    required this.errText,
    required this.isError,
    required this.isLoad,
    required this.isSuccess,
    this.user
});
  

  CommonState copyWith({
    String? errText,
    bool? isError,
    bool? isSuccess,
    bool? isLoad,
    User? user
}){
    return CommonState(
        errText: errText ?? this.errText,
        isError: isError ?? this.isError,
        isLoad: isLoad ?? this.isLoad,
        isSuccess: isSuccess ?? this.isSuccess,
       user: user
    );
  }


}