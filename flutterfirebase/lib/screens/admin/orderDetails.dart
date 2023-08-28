import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/services/store.dart';

import '../../models/product.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();

  @override
  Widget build(BuildContext context) {
    String? documentId = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrdersDetails(documentId),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Product> products=[];
            for(var doc in snapshot.data!.docs){
              var data = doc.data() as Map;
              products.add(Product(
                pType: data[kProductType] ,
                pQuantity: data[kQuantity],
                pLocation: data[kProductLocation],

              ));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                   itemBuilder: (context,index)=> Padding(
                     padding: const EdgeInsets.all(20),
                     child: Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height*0.2,
                        color: LightColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Product Type =  ${products[index].pType}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold

                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text(' Quantity = ${products[index].pQuantity}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold

                              ),),
                            const SizedBox(height: 20,),
                            Text(' Location = ${products[index].pLocation}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold

                              ),),

                          ],
                        ),
                      ),
                   ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [


                    MaterialButton(
                      color: Primary,
                      onPressed: (){},
                     child: Text('Confirm Order'),
                    ),
                    MaterialButton(
                      color: Primary,
                      onPressed: (){},
                     child: Text('Delete Order'),
                    ),
                  ],
                )
              ],
            );
          }else
            {
              return Center(
                child: Text('Loading Orders ya 3aamm '),
              );
            }

        },

      ),
    );
  }
}
