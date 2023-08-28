// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutterfirebase/provider/cartItem.dart';
import 'package:provider/provider.dart';

import '../../component/constant.dart';
import '../../models/product.dart';
import 'CartScreen.dart';

class ProductInfo extends StatefulWidget {
  static String id='ProductInfo';
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;
  @override
  Widget build(BuildContext context) {
    final Product? product =ModalRoute.of(context)!.settings.arguments as Product? ;
    return Scaffold(
      backgroundColor: Primary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              margin: EdgeInsets.only(top: 20),

              height: MediaQuery.of(context).size.height * .07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      icon: Icon(Icons.arrow_back_ios_sharp)),

                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.home_work_rounded))
                ],
              ),
            ),
          ),
          Image.asset(product!.pImage! ),
          Expanded(
            child: Container(
              color: Primary,
              child: Column(

                children: <Widget>[
                  Text('\nHouse Type : ${product.pType!}\n',
                    style: TextStyle(
                        fontSize: 20,
                      fontWeight: FontWeight.bold),
                  ),
                  Text('House Location : ${product.pLocation!}',
                    style: TextStyle(
                        fontSize: 14,
                      fontWeight: FontWeight.bold),
                  ),
                  Text('\n House Price : \$ ${product.pPrice!}\n',
                    style: TextStyle(
                        fontSize: 20,
                      fontWeight: FontWeight.bold),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Material(
                          color: LightColor,
                          child: GestureDetector(
                            onTap: addition,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.add
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontSize: 50
                        ),
                      ),
                      SizedBox(width: 20,),
                      ClipOval(
                        child: Material(
                          color: LightColor,
                          child: GestureDetector(
                            onTap: sub,
                            child: SizedBox(
                              child: Icon(
                                  Icons.remove
                              ),
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return MaterialButton(

                color: SecondaryColor,
                onPressed: (){
                 addToCart(context,product);

                },
                child: Text('Add to chart'.toUpperCase(),style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,fontSize: 18),),
              );
            }
          ),
          SizedBox(
            height: 40,
          ),

        ],

      ),
    );
  }

  sub()
  {
    if(_quantity>0){
    setState(() {
      _quantity--;
    });
    }


  }

  addition() {
    setState(() {
      _quantity++;
    });

  }

  void addToCart(context,product)
  {
    CartItem cartItem= Provider.of<CartItem>(context,listen: false);
    product.pQuantity=_quantity;
    bool exist=false;
    var productsInCart=cartItem.products;
    for(var productInCart in productsInCart){
      if (productInCart.pImage.toString() == product.pImage.toString() )
        {
          exist= true;
        }
    }
    if(exist){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('you \'ve added this item before'),),
      );
    }else{
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Add to cart Successfully'),),
      );
    }

  }
}
