// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/screens/register/login_screen.dart';
import 'package:flutterfirebase/screens/user/productInfo.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/productView.dart';
import '../../component/functions.dart';
import '../../models/product.dart';
import 'CartScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = Auth();
  int _tabBarIndex = 0;
  int _buttomBarIndex = 0;
  final _store=Store();
  List<Product> _products=[];

  // FirebaseUser _firebaseUser;
  // @override
  // void initState() {
  //   getCurrentUser();
  // }
  // getCurrentUser() async{
  //   _loggedUser=await _auth;
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Primary,
              bottom: TabBar(
                indicatorColor: SecondaryColor,
                onTap: (value) {
                  setState(() {
                    _tabBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Other',
                    style: TextStyle(
                      color: _tabBarIndex == 0 ? Colors.black : SecondaryColor,
                      fontSize: _tabBarIndex == 0 ? 15 : null,
                    ),
                  ),
                  Text(
                    'Work Shop',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? Colors.black : SecondaryColor,
                      fontSize: _tabBarIndex == 1 ? 14 : null,
                    ),
                  ),
                  Text(
                    'Villa',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? Colors.black : SecondaryColor,
                      fontSize: _tabBarIndex == 2 ? 16 : null,
                    ),
                  ),
                  Text(
                    'House',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? Colors.black : SecondaryColor,
                      fontSize: _tabBarIndex == 3 ? 16 : null,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _buttomBarIndex,
              fixedColor: SecondaryColor,
              onTap: (value) async{

                if(value==3){
                  SharedPreferences pref=await SharedPreferences.getInstance();
                  pref.clear();
                 await _auth.SignOut();
                 Navigator.popAndPushNamed(context,LoginScreen.id);
                }
                setState(() {
                  _buttomBarIndex=value;
                });

              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.location_on),label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person),
                    label: 'Sign Out'),


              ],
            ),
            body: TabBarView(
              children: [

                ProductView(kApartment,_products),
                ProductView(kWorkShop,_products),
                ProductView(kVilla,_products),
                HouseView(),
                // HouseView(),
                // HouseView(),
                // HouseView(),

              ],
            ),
          ),
        ),
        Material(
          color: Primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              color: Primary,
              height: MediaQuery.of(context).size.height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'aqary'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.home_work_rounded))
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

 Widget HouseView()
 {
   return StreamBuilder<QuerySnapshot>(
       stream: _store.loadProducts(),
       builder: (context, snapshot) {
         if (snapshot.hasData) {
           List<Product>? products = [];
           for (var doc in snapshot.data!.docs) {
             var data = doc.data() as Map;
             // if (doc[kProductType] == kHouse) {
               products.add(Product(
                   pId: doc.id,
                   pType: data[kProductType],
                   pPrice: data[kProductPrice],
                   pLocation: data[kProductLocation],
                   pImage: data[kProductImage]));

           }
           _products=[...products];
           products.clear();
           products=getProductByType(kHouse,_products);

           return GridView.builder(

             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 1),
             itemBuilder: (context, index) => Padding(
               padding: const EdgeInsets.symmetric(vertical: 10),
               child: GestureDetector(
                 onTap: (){
                   setState(() {
                     Navigator.pushNamed(context, ProductInfo.id,arguments: _products[index]);
                   });
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
         } else {
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
       }
       );

 }


  // List<Product> getAllProduct(String kHouse) {
  //   List<Product> products=[];
  //   return products;
  // }


}
