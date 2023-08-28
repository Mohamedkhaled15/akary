import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/screens/admin/editProduct.dart';

import '../../component/constant.dart';

import '../../component/custom_menu.dart';
import '../../models/product.dart';
import '../../services/store.dart';

class ManageProducts extends StatelessWidget {
  static String id = 'ManageProducts';

  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data!.docs) {
                var data = doc.data() as Map;

                products.add(Product(
                    pId: doc.id,
                    pType: data[kProductType],
                    pPrice: data[kProductPrice],
                    pLocation: data[kProductLocation],
                    pImage: data[kProductImage]));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.width - dy;
                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                                onClick: () {
                                  Navigator.pushNamed(context, EditProduct.id,
                                      arguments: products[index]);
                                },
                                child: Text('Edit')),
                            MyPopupMenuItem(
                                onClick: () {
                                  _store.deleteProduct(products[index].pId!);
                                  Navigator.pop(context);
                                },
                                child: Text('Delete')),
                          ]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Image.asset(
                                fit: BoxFit.fill, products[index].pImage!)),
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
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

