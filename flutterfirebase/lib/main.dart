import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';
import 'package:flutterfirebase/provider/adminMode.dart';
import 'package:flutterfirebase/provider/cartItem.dart';
import 'package:flutterfirebase/provider/model_hud.dart';
import 'package:flutterfirebase/screens/admin/add_product.dart';
import 'package:flutterfirebase/screens/admin/adminHome.dart';
import 'package:flutterfirebase/screens/admin/ManageProduct.dart';
import 'package:flutterfirebase/screens/admin/editProduct.dart';
import 'package:flutterfirebase/screens/admin/orderDetails.dart';
import 'package:flutterfirebase/screens/admin/view_product.dart';
import 'package:flutterfirebase/screens/register/login_screen.dart';
import 'package:flutterfirebase/screens/register/signup_screen.dart';
import 'package:flutterfirebase/screens/user/CartScreen.dart';
import 'package:flutterfirebase/screens/user/home_screen.dart';
import 'package:flutterfirebase/screens/user/productInfo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  bool isUserLoggedIn=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    'Loading...'
                  ),
                ),
              ),
            );
          }else{
            isUserLoggedIn=snapshot.data!.getBool(kKeepMeLogedIn)?? false ;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                  create: (context) => ModelHud(),
                ),
                ChangeNotifierProvider<AdminMod>(
                  create: (context) => AdminMod(),
                ),
                ChangeNotifierProvider<CartItem>(
                  create: (context) => CartItem(),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute:isUserLoggedIn? HomeScreen.id: LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignupScreen.id: (context) => SignupScreen(),
                  // HomeScreen.id:(context)=>HomeScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AdminHome.id:(context)=>AdminHome(),
                  AddProduct.id:(context)=>AddProduct(),
                  ManageProducts.id:(context)=>ManageProducts(),
                  ViewProduct.id:(context)=>ViewProduct(),
                  EditProduct.id:(context)=>EditProduct(),
                  ProductInfo.id:(context)=>ProductInfo(),
                  CartScreen.id:(context)=>CartScreen(),
                  OrderDetails.id:(context)=>OrderDetails(),

                },
              ),
            );
          }
        }

    );
  }
}
