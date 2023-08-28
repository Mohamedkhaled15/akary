
import 'package:flutter/material.dart';
import 'package:flutterfirebase/component/constant.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final IconData? icon;

  final Function(String?)? onClick;
  String? _errorMessage(String str){
    switch(hint) {
      case 'Enter your Name ': return 'Name is Empty';
      case 'Enter your Email ': return 'Email is Empty';
      case 'Enter your password': return 'password is Empty';
        
    }
    return '';
      
    
  }

   CustomTextField({

     this.hint,   this.icon, this.onClick});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20) ,

      child: TextFormField(

        validator:(value){
          if(value!.isEmpty){
            return _errorMessage(hint!);
          }
        },

        onSaved: onClick,



        obscureText: hint=='Enter your password'?true:false,
        cursorColor: PrimaryColor,

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            icon,
            color: PrimaryColor,),
          filled: true,
          fillColor: LightColor,

          enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: SecondaryColor)
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: SecondaryColor)
          ),
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: SecondaryColor)
          ),

        ),

      ),
    );
  }

}