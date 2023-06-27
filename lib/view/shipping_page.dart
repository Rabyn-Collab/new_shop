import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutternew/common/snack_show.dart';
import 'package:flutternew/constants/sizes.dart';
import 'package:flutternew/provider/auth_provider.dart';
import 'package:flutternew/view/signup_page.dart';
import 'package:get/get.dart';


class ShippingPage extends ConsumerStatefulWidget{

  @override
  ConsumerState<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends ConsumerState<ShippingPage> {
  final addressController = TextEditingController();

  final cityController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        SnackShow.showFailure(context,next.errText);
      }else if(next.isSuccess){
        Get.back();
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
                      controller: addressController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide your address';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Your Address',
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                      ),
                    ),
                    gapH20,
                    TextFormField(
                      controller: cityController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'please provide your city';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'City',
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

                             ref.read(authProvider.notifier).userUpdate(
                                 address: addressController.text.trim(),
                                 city: cityController.text.trim(),
                                 token: auth.user!.token,
                               user: auth.user!
                             );
                          }
                        },
                        child: auth.isLoad ? Center(child: CircularProgressIndicator(
                          color: Colors.white,
                        )): Text('Submit')),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
