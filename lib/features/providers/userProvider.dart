import 'package:flutter/material.dart';
import 'package:style/components/models/user.dart';
import 'package:style/features/repositories/user_client.dart';
import 'package:style/services/auth.dart';

class UserProvider extends ChangeNotifier{
    String email;
    String password;
    setEmail(String email){
      this.email=email;
    }
    setPassword(String pass){
      this.password=pass;
    } 

    addNewUserInfo(String useremail,String userpassword)async{
      try{
       
        String userId=await Auth.auth.createUserUsingEmailAndPassword(useremail, userpassword);
      if(userId!=null){
        
        User user=User(email: useremail,password: userpassword,documentUserId: userId);
        UserClient.userClient.addNewUser(user);
        notifyListeners();
      }
      }catch(e){
        print(e);
      }
      
    }

    Future<bool> isAdmin()async{
    String iserId=await Auth.auth.signInUsingEmailAndPassword(this.email, this.password);
      bool s=await UserClient.userClient.isAdmin(iserId);
      return s;
    }
    
}