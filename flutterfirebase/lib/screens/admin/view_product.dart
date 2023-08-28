import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/services/store.dart';
import 'package:flutterfirebase/models/order.dart';

import 'orderDetails.dart';


class ViewProduct extends StatelessWidget {
  static String id='ViewProduct';
  final Store _store =Store();



  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:_store.loadOrders() ,
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: Text('there is no order'),
            );
          }else{
            List<Orders> orders=[];
            for(var doc in snapshot.data!.docs){
              var data = doc.data() as Map;
              orders.add(Orders(
                documentId: doc.id,
                totalPrice: data[kTotallPrice],
                address: data[kAddress],

              ));
            }

            return ListView.builder(
                itemCount: orders.length,
                itemBuilder:
                (context,index)=>
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, OrderDetails.id,
                         arguments: orders[index].documentId
                         );
                       },
                       child: Container(
                         padding: EdgeInsets.all(10),
                         height: MediaQuery.of(context).size.height*0.2,
                         color: LightColor,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Totall Price = \$ ${orders[index].totalPrice}',
                               style: TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.bold

                               ),
                             ),
                             SizedBox(height: 20,),
                             Text(' Address = ${orders[index].address}',
                               style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold

                               ),),
                           ],
                         ),
                       ),
                     ),
                   )
            );
          }
        },
      )

    );
  }
}
