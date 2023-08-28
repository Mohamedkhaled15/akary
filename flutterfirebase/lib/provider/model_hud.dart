import 'package:flutter/material.dart';

class ModelHud extends ChangeNotifier {
  bool isLoading=false;
  changeKsLoading(bool value){
    isLoading=value;
    notifyListeners();

  }

}
