import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/values/strings.dart';

class AdminClient{
  AdminClient._();
  static final AdminClient adminClient=AdminClient._();

  Firestore firestore=Firestore.instance;
  FirebaseStorage firebaseStorage=FirebaseStorage.instance;

  // upload image
  Future<String> uploadImage(File file,String imgFolder)async{
    try{
      DateTime dateTime=DateTime.now();
      StorageTaskSnapshot storageTaskSnapshot=await firebaseStorage.ref().child('$imgFolder/$dateTime.jpg').putFile(file).onComplete;
      String imgurl=await storageTaskSnapshot.ref.getDownloadURL();
      return imgurl;
    }catch(error){
      print(error);
    }
  }
  //! upload image

  // operations on categories
  Future<String> addNewCategory(Category category)async{
    try{
      DocumentReference documentReference=await firestore.collection(categoriesCollectionName).add(category.toJson());
      String documentID=documentReference.documentID;
      return documentID;
    }
    catch(error){
      print(error);
    }
  }

  editCategory(Category category)async{
    try{
        firestore.collection(categoriesCollectionName).document(category.documentId).setData(category.toJson());
    }catch(error){
        print(error);
    }
  }

  deleteCategory(Category category)async{
    try{
      if(category.imageUrl!=null){
        StorageReference storageReference=await firebaseStorage.getReferenceFromUrl(category.imageUrl);
        storageReference.delete();
      }
        firestore.collection(categoriesCollectionName).document(category.documentId).delete();
    }catch(error){
      print(error);
    }
  }

  Future<List<DocumentSnapshot>> getAllCategories()async{
    try{
      QuerySnapshot querySnapshot=await firestore.collection(categoriesCollectionName).getDocuments();
    List<DocumentSnapshot> categoriesDocsSnapshot=querySnapshot.documents;
    return categoriesDocsSnapshot;
    }catch(error){
      print(error);
    }
  }
  // ! operations on categories


  // operations on products
  Future<String> addNewProduct(Product product)async{
    try{
        DocumentReference documentReference=
        await firestore.collection(producstCollectionName).add(product.toJson());
        return documentReference.documentID;
    }catch(error){
      print(error);
      }
  }
  
  editProduct(Product product)async{
    try{
      firestore.collection(producstCollectionName).document(product.documentId).setData(product.toJson());
    }catch(error){
      print(error);
      }
  }
 
  deleteProduct(Product product)async{
    try{
      String imgUrl=product.imageUrl;
      if(imgUrl!=null){
        StorageReference storageReference=await firebaseStorage.getReferenceFromUrl(imgUrl);
        await storageReference.delete();
      }
      firestore.collection(producstCollectionName).document(product.documentId).delete();

    }catch(error){
      print(error);
      }
  }
  
  Future<List<DocumentSnapshot>> getAllProducts()async{
    try{
      QuerySnapshot querySnapshot=await firestore.collection(producstCollectionName).getDocuments();
      List<DocumentSnapshot> produstDocsSnapshot=querySnapshot.documents;
      return produstDocsSnapshot;
    }catch(error){
      print(error);
      }
  }
  
  Future<List<DocumentSnapshot>> getCategorizedProducts(String categoryName)async{
   try{
     QuerySnapshot querySnapshot=await firestore.collection(producstCollectionName).where(pCategoryname,isEqualTo: categoryName).getDocuments();
     List<DocumentSnapshot> categorizedProdustDocsSnapshot=querySnapshot.documents;
     return categorizedProdustDocsSnapshot;
   }catch(error){
     print(error);
   }
  }
  // ! operations on products


  // operations of users
  // this method for admin
  Future<List<DocumentSnapshot>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(usersCollectionName).getDocuments();
      List<DocumentSnapshot> usersDocumentSnapshot = querySnapshot.documents;
      return usersDocumentSnapshot;
    } catch (e) {
      print(e);
    }
  }

}