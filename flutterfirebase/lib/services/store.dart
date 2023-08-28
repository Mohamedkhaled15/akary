import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/models/product.dart';

import '../component/constant.dart';

class Store {
  final _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductType: product.pType,
      kProductPrice: product.pPrice,
      kProductLocation: product.pLocation,
      // kProductCategory:product.pCategory,
      kProductImage: product.pImage,
      // kProductDescription:product.pDescription,
    });
  }

  Stream<QuerySnapshot> loadProducts() {

    return _firestore.collection(kProductCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrders(){
    return _firestore.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot> loadOrdersDetails(documentId){
    return _firestore.collection(kOrders).doc(documentId).collection(kOrdersDetails).snapshots();
  }
  deleteProduct(documentID){
    _firestore.collection(kProductCollection).doc(documentID).delete();
  }
  editProduct(data,docId){
    _firestore.collection(kProductCollection).doc(docId).update(data);
  }



  storeOrder(data,List<Product> products)
  {
    var docRef =
    _firestore.collection(kOrders).doc();

    docRef.set(data);
    for(var product in products)
      {
        docRef.collection(kOrdersDetails).doc().set(
          {
           kProductLocation:product.pLocation,
            kProductType: product.pType,
            kProductPrice: product.pPrice,
            kQuantity:product.pQuantity,
            kProductImage: product.pImage,

          }
        );

      }

  }
}
