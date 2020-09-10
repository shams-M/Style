import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:style/values/strings.dart';

class User{
  String documentUserId;
  String email;
  String password;
  int isAdmin;    // 0 for customer , 1 for admin
  String userImgUrl;
  User({this.documentUserId,this.email,this.password,this.isAdmin=0,this.userImgUrl='https://firebasestorage.googleapis.com/v0/b/flutter-training-a9685.appspot.com/o/usersImgs%2Fuserprofile.png?alt=media&token=f2ebe78c-4f08-43f7-a732-eae2c3f667e6'});

  toJson(){
    return {
      uEmail:this.email,
      uPassword:this.password,
      uAdmin:this.isAdmin,
      uImgUrl:this.userImgUrl
    };
  }
  User.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.documentUserId=documentSnapshot.documentID;
    this.email=documentSnapshot.data[uEmail];
    this.password=documentSnapshot.data[uPassword];
    this.isAdmin=documentSnapshot.data[uAdmin];
    this.userImgUrl=documentSnapshot.data[uImgUrl];
  }
}