import 'package:flutter/material.dart';

import '../../component/custom_textfield.dart';
import '../../component/constant.dart';
import '../../models/product.dart';
import '../../services/store.dart';

class EditProduct extends StatelessWidget {
  static String id='EditProduct.id';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  final _store=Store();
  String? _type,_price,_location,_image;

  @override
  Widget build(BuildContext context) {
   final Product? product =ModalRoute.of(context)!.settings.arguments as Product? ;
    return Scaffold(
        backgroundColor: SecondaryColor,
        body: Form(
          key: _globalKey,
          child: ListView(
            children:[
              SizedBox(
                height:MediaQuery.of(context).size.height*0.1,
              ),
              Column(
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

                      _store.editProduct(({
                        kProductType: _type,
                        kProductPrice: _price,
                        kProductLocation: _location,
                        kProductImage: _image

                      }), product?.pId);


                    }
                  },
                  child: const Text('confirm edit '),
                ),
              ],
            ),
          ]
          ),
        ));
  }
}
