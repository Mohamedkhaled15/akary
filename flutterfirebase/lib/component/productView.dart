import '../screens/user/productInfo.dart';
import 'constant.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';
Widget ProductView(String pType,List<Product> allProducts) {
  List<Product>? products;
  products=getProductByType(pType,allProducts);

  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ProductInfo.id,arguments:products![index] );
        },

        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
                    fit: BoxFit.fill, products![index].pImage!)),
            Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: Primary,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          products[index].pType!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        Text(
                          '\$ ${products[index].pPrice}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    ),
    // Column(
    //   children: [
    //     Image.asset(products[index].pImage!),
    //     Text(products[index].pType!),
    //   ],
    // ),
    itemCount: products.length,
  );

}
List<Product> getProductByType(String kHouse, List<Product> allProducts) {
  List<Product> products =[];
  // try {
    for (var product in allProducts) {
      if (product.pType == kHouse) {
        products.add(product);
      }
    }
  // } on Error catch (ex) {
  //   print(ex);
  // }
  // print(products);
  return products;

}
