import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style/values/strings.dart';

class Category{
  String documentId;
  String name;
  String imageUrl;
  Category({this.name,this.imageUrl});
  toJson(){
    return{
      cName:this.name,
      cImageUrl:this.imageUrl,
    };
  }
  Category.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.documentId=documentSnapshot.documentID;
    this.name=documentSnapshot.data[cName];
    this.imageUrl=documentSnapshot.data[cImageUrl];
  }
}