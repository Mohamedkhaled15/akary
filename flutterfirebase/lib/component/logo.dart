// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'constant.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        height: MediaQuery.of(context).size.height*0.3,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('assets/images/3quary.png'),
            height: MediaQuery.of(context).size.height/5,),
      
            Positioned(
              bottom: 0,
              
              child: Text('Aqary',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Light
                ),))
          ],
        ),
      ),
    );
  }
}