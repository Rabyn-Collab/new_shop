import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/view/signup_page.dart';
import 'package:get/get.dart';


class LoginPage extends ConsumerStatefulWidget{

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final mailController = TextEditingController();

  final passController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        SnackShow.showFailure(context,next.errText);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'success');
      }

    });


    final auth = ref.watch(authProvider);

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

                    Text('User Login', style: TextStyle(fontSize: 20),),

                    gapH20,
                    TextFormField(
                      controller: mailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val){
                        bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val!);
                        if(val.isEmpty){
                          return 'please provide your email';
                        }else if(!emailValid){
                          return 'please provide valid email';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Your Email',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide your password';
                        }
                        // else if( val.length < 5){
                        //   return 'minimum character is  4';
                        // }else if(val.length > 20){
                        //   return 'maximum character is less than 20';
                        // }

                        return null;
                      },
                      // obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,

                    gapH20,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5)
                        ),
                        onPressed: (){
                          FocusScope.of(context).unfocus();
                          _form.currentState!.save();
                          if(_form.currentState!.validate()){

                            ref.read(authProvider.notifier).userLogin(
                                email: mailController.text.trim(),
                                password: passController.text.trim(),
                            );


                          }
                        },
                        child: auth.isLoad ? Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        )): Text('Submit')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an Account'),
                        TextButton(onPressed: (){
                          Get.to(() => SignUpPage());
                        }, child: Text('Sign Up'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
