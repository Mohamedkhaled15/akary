// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebase/provider/adminMode.dart';
import 'package:flutterfirebase/provider/model_hud.dart';
import 'package:flutterfirebase/screens/admin/adminHome.dart';
import 'package:flutterfirebase/screens/register/signup_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/custom_textfield.dart';
import '../../component/logo.dart';
import '../../component/constant.dart';
import '../../services/auth.dart';
import '../../ui/home.dart';

import '../user/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String? _email, _password;

  bool isAdmin = false;

  final adminPassword = '1234567';

  get _auth => Auth();

  bool keepMeLoggedIn= false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: SecondaryColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Logo(),
                SizedBox(height: height * 0.07),
                CustomTextField(
                  onClick: (value) {
                    _email = value;
                  },
                  hint: 'Enter your Email ',
                  icon: Icons.email,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Remember Me',style: TextStyle(color: Light, fontSize: 16),
                    ),
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(

                          checkColor: LightColor,
                          activeColor: PrimaryColor,
                          value: keepMeLoggedIn,
                          onChanged: (value){
                        setState(() {
                          keepMeLoggedIn =value!;

                        });

                          }),
                    ),
                  ],
                ),
                CustomTextField(
                  onClick: (value) {
                    _password = value;
                  },
                  hint: 'Enter your password',
                  icon: Icons.lock,
                ),
                SizedBox(height: height * 0.07),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3.5),
                  child: Container(
                    height: height * 0.06,
                    child: Builder(
                      builder: (context) => MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: MaterialStateColor.resolveWith(
                            (states) => PrimaryColor),
                        onPressed: (){

                          if(keepMeLoggedIn == true){
                            keepUserLoggedIn();
                          }

                          _validate(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: LightColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account ?  ',
                      style: TextStyle(color: Light, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.id);
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(fontSize: 16, color: SecondaryColor),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<AdminMod>(context, listen: false)
                                .changeIsAdmin(true);
                          },
                          child: Text(
                            'i\'m an admin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMod>(context).isAdmin
                                    ? PrimaryColor
                                    : Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<AdminMod>(context, listen: false)
                                .changeIsAdmin(false);
                          },
                          child: Text(
                            'i\'m an user',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Provider.of<AdminMod>(context).isAdmin
                                    ? Colors.white
                                    : PrimaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeKsLoading(true);
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      if (Provider.of<AdminMod>(context,listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
           await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {

            modelHud.changeKsLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.toString()),
            ));
          }
        } else {
          modelHud.changeKsLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Somthing went wrong'),
          ));
        }
      } else {
        try {
         await _auth.signIn(_email, _password);

          Navigator.pushNamed(context, HomeScreen.id);
        } catch (e) {


          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
          ));
        }
      }
      }
      modelHud.changeKsLoading(false);
    }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLogedIn, keepMeLoggedIn);
  }
}
