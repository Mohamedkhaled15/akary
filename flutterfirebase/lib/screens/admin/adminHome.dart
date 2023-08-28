import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/screens/admin/add_product.dart';
import 'package:flutterfirebase/screens/admin/ManageProduct.dart';
import 'package:flutterfirebase/screens/admin/view_product.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: PrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, AddProduct.id);
            },
            leading: const Icon(Icons.add_business,size:35,color: LightColor,),
            title: const Text('Add real state',style: TextStyle(color: Colors.white,fontSize: 25),),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, ManageProducts.id);
            },
            leading: const Icon(Icons.edit_note_sharp,size:35,color: LightColor,),
            title: const Text('Edit real state',style: TextStyle(color: Colors.white,fontSize: 25),),
          ),
          ListTile(
            onTap: (){
              Navigator.pushNamed(context, ViewProduct.id);
            },
            leading: const Icon(Icons.hive_rounded,size:35,color: LightColor,),
            title: const Text('View real state',style: TextStyle(color: Colors.white,fontSize: 25),),
          ),

        ],
      ),
    );
  }
}
