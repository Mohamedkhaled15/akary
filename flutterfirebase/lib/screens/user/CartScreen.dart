

import 'package:flutter/material.dart';
import 'package:flutterfirebase/models/product.dart';
import 'package:flutterfirebase/provider/cartItem.dart';
import 'package:flutterfirebase/screens/user/productInfo.dart';
import 'package:provider/provider.dart';

import '../../component/constant.dart';
import '../../component/custom_menu.dart';
import '../../services/store.dart';

class CartScreen extends StatelessWidget {
  static String id ='CartScreen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
   List<Product> products= Provider.of<CartItem>(context).products;
   final double screenHeight=MediaQuery.of(context).size.height;
   final double screenWidth=MediaQuery.of(context).size.width;
   final double appBarHeight=AppBar().preferredSize.height;
   final double statusBarHeight=MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: SecondaryColor,
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder: (context,constrains) {
              if(products.isEmpty){
                return Container(
                    height: screenHeight-(screenHeight * 0.07)-appBarHeight-statusBarHeight,
                    child: const Center(child: Text('Cart is empty',style: TextStyle(
                      fontSize: 20,

                      fontWeight: FontWeight.bold,
                    ),),));
              }else{
                return Container(
                  height: screenHeight-(screenHeight * 0.07)-appBarHeight-statusBarHeight,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTapUp: (details){
                            shoCustomMenu(details,context,products[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            height: screenHeight * .2,
                            color: Primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  radius: screenHeight * 0.15 / 2,
                                  backgroundImage: AssetImage(
                                    products[index].pImage!,

                                  ),
                                ),
                                SizedBox(width: 30,),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,

                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(products[index].pType!,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('\n\$ ${products[index].pPrice!}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(products[index].pQuantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                );
              }
              
            }
          ),
          Container(
            width: screenWidth,
            height: screenHeight *0.07,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: MaterialButton(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: MaterialStateColor.resolveWith(
                        (states) => SecondaryColor),
                onPressed: (){
                showCustomDialog(products,context);

                },
              child: const Text(
                'Order',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),)
            ),
          ),
        ],
      ),
    );
  }

  void shoCustomMenu(details,context,product) async{
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.width - dy;
   await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
              onClick: () {
                Navigator.pop(context);
                Provider.of<CartItem>(context,listen: false).deleteProduct(product);
                Navigator.pushNamed(context, ProductInfo.id,arguments: product);

              },
              child: const Text('Edit')),
          MyPopupMenuItem(
              onClick: () {
                Navigator.pop(context);
                Provider.of<CartItem>(context,listen: false).deleteProduct(product);


              },
              child: const Text('Delete')),
        ]);
  }

  void showCustomDialog(List<Product> products,context) async
  {
    var price =getTotallPrice(products);
    var address;
    AlertDialog alertDialog=AlertDialog(
      actions: [
        Builder(
          builder: (context) {
            return MaterialButton(
                onPressed: (){
                  try {
                    Store _store = Store();
                    _store.storeOrder({
                      kTotallPrice: price,
                      kAddress: address,

                    }, products);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content:Text('Orderd Successfuly') )
                    );
                    Navigator.pop(context);
                  }catch (ex)
                  {
                    print(ex);
                  }
                },
              child: const Text('Confirm'),

            );
          }
        ),
      ],
      content: TextField(
        onChanged: (value){
          address=value;
        },
        decoration: InputDecoration(
          hintText: 'Enter your Address'
        ),
      ),
      title: Text('Total Price = \$  $price'),
    );
    await showDialog(context: context, builder: (context){
      return alertDialog;

    });
  }

  getTotallPrice(List<Product> products) {
    var price =0;
    for(var product in products){
      price += (product.pQuantity! * int.parse(product.pPrice!));
    }
    return price;
  }
}
