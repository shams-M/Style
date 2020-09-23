import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:style/components/models/user.dart';
import 'package:style/values/strings.dart';

class UserClient {
  UserClient._();
  static final UserClient userClient = UserClient._();
  Firestore firestore = Firestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // this method must called when new user is registerd
  addNewUser(User user) async {
    print(user.toJson());
    try {
      await firestore
          .collection(usersCollectionName)
          .document(user.documentUserId)
          .setData(user.toJson());
    } catch (e) {
      print(e);
    }
  }
  // addNewUserToFirestore(User user)async{
  //   // documentId here is the uid of the user
  //   await firestore.collection('users').document(user.documentUserId).setData(user.toJson());
  // }

  // this method for admin and customer
  changePassword(User user) async {
    try {
      firestore
          .collection(usersCollectionName)
          .document(user.documentUserId)
          .setData({uPassword: user.password});
    } catch (e) {
      print(e);
    }
  }

  // this method for admin and customer
  Future<String> uploadUserImg(File file) async {
    try {
      DateTime dateTime = DateTime.now();
      StorageTaskSnapshot storageTaskSnapshot = await firebaseStorage
          .ref()
          .child('usersImgsFolder/$dateTime.jpg')
          .putFile(file)
          .onComplete;
      String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return imgUrl;
    } catch (e) {
      print(e);
    }
  }

  // this method for admin and customer
  changeUserImg(User user) async {
    try {
      firestore
          .collection(usersCollectionName)
          .document(user.documentUserId)
          .setData({uImgUrl: user.userImgUrl});
    } catch (e) {
      print(e);
    }
  }



  // this method is for user to show his info // is is not complete yet
  Future<DocumentSnapshot> isAdmin(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot =await firestore.collection(usersCollectionName).document(documentId).get();
      return documentSnapshot;

    } catch (e) {
      print(e);
    }
  }
}
