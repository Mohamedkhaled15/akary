import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/models/product.dart';
import 'package:flutterfirebase/services/store.dart';

import '../../component/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  final _store=Store();
  String? _type,_price,_location,_image;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SecondaryColor,
        body: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'RealState type',
                onClick: (value){
                  _type=value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hint: 'RealState Price',
                onClick: (value){
                  _price=value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomTextField(
              //   hint:'RealState Description' ,
              //
              //
              // ),
              CustomTextField(
                hint: 'RealState Location',
                onClick: (value){
                  _location=value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // CustomTextField(
              //   hint:'RealState Category' ,
              //
              //
              // ),
              CustomTextField(
                hint: 'RealState Image',
                onClick: (value){
                  _image=value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: MaterialStateColor.resolveWith((states) =>
                Primary),
                onPressed: () {
                  if(_globalKey.currentState!.validate())
                  {
                    _globalKey.currentState!.save();
                    _store.addProduct(Product(
                      pType: _type,
                      pPrice: _price,
                      pLocation: _location,
                      pImage: _image
                    ));

                  }
                },
                child: const Text('Add realState'),
              ),
            ],
          ),
        ));
  }
}
