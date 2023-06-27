




import 'package:flutter/material.dart';
import 'package:flutternew/view/cart_page.dart';
import 'package:get/get.dart';

class SnackShow{

  static showSuccess(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
            content: Text(msg, style: TextStyle(color: Colors.white),)
        ));
  }


  static showFailure(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            duration: Duration(seconds: 1),
            content: Text(msg)
        ));
  }

  static shopShow(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(label: 'Go TO Cart', onPressed: (){
            Get.to(() => CartPage());
          }),
            backgroundColor: Colors.white,
            duration: Duration(seconds: 1),
            content: Text(msg)
        ));
  }

}