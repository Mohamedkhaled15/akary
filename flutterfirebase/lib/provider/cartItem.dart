import 'package:flutter/cupertino.dart';
import 'package:flutterfirebase/models/product.dart';

class CartItem extends ChangeNotifier
{
  List<Product> products=[];
  addProduct(Product product)
  {
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();
  }

}