import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style/values/strings.dart';

class Product{
  String documentId;   // from firestore
  String name;
  String description;
  String imageUrl;
  dynamic price;
  bool isAvailable;
  String categoryname; 

  Product({this.documentId,this.name,this.description,this.imageUrl,this.price,this.isAvailable,this.categoryname});
  toJson(){
    return {
      pName:this.name,
      pDescription:this.description,
      pImageUrl:this.imageUrl,
      pPrice:this.price,
      pIsAvailable:this.isAvailable,
      pCategoryname:this.categoryname
    };
  }
  Product.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.documentId=documentSnapshot.documentID;
    this.name=documentSnapshot.data[pName];
    this.description=documentSnapshot.data[pDescription];
    this.imageUrl=documentSnapshot.data[pImageUrl];
    this.price=documentSnapshot.data[pPrice];
    this.isAvailable=documentSnapshot.data[pIsAvailable];
    this.categoryname=documentSnapshot.data[pCategoryname];
    
  }

}