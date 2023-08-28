import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebase/provider/model_hud.dart';
import 'package:flutterfirebase/ui/home.dart';
import 'package:provider/provider.dart';
import '../../component/custom_textfield.dart';
import '../../component/logo.dart';
import '../../component/constant.dart';
import '../../services/auth.dart';
import '../../component/variable.dart';

import '../user/home_screen.dart';
import 'login_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupScreen extends StatelessWidget {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String? _name,_email,_password;
  get _auth => Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return  Scaffold(
          backgroundColor: PrimaryColor,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isLoading,
            child: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  Logo(),
                  SizedBox(height: height * 0.07),
                  CustomTextField(
                    onClick: (value){
                      _name=value;
                      value=nameHead!;
                    },
                    hint: 'Enter your Name ',
                    icon: Icons.person,
                  ),
                  SizedBox(height: height * 0.03),
                  CustomTextField(
                    onClick: (value){
                      _email=value;
                    },
                    hint: 'Enter your Email ',
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  CustomTextField(

                    onClick: (value){
                      _password=value;
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
                        builder:(context)=> MaterialButton(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            color: MaterialStateColor.resolveWith(
                                (states) => SecondaryColor),

                          onPressed: () async{
                              final modelHud=Provider.of<ModelHud>(context,listen: false);
                              modelHud.changeKsLoading(true);
                            if (_globalKey.currentState!.validate()) {
                              _globalKey.currentState!.save();
                              // print(_email);
                              // print(_password);
                              try {
                                final authResult = await _auth.signUp(
                                    _email!.trim(), _password!.trim());
                                modelHud.changeKsLoading(false);
                                Navigator.pushNamed(context, HomeScreen.id);
                              } catch(e){
                                print(e.toString());
                                modelHud.changeKsLoading(false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text(
                                         e.toString()
                                     ),)

                                );

                              }

                              //do something ybn el wesek
                            }
                            modelHud.changeKsLoading(false);

                          },
                          child: const Text(
                            'SignUp',
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
                      const Text(
                        'arlady have account !  ',
                        style: TextStyle(color: Light, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: SecondaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
    );
  }
}
