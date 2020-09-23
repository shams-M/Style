import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:style/components/models/user.dart';
import 'package:style/features/repositories/user_client.dart';
import 'package:style/features/repositories/user_repository.dart';
import 'package:style/services/auth.dart';

class UserProvider extends ChangeNotifier{
    String email;
    String password;
    int admin=0;
    final loginFormKey = GlobalKey<FormState>();
    final createAccountFormKey=GlobalKey<FormState>();
    bool autoValidate = false;
    String message;
    bool isVisible = false;
    bool isLogged=false;   // for login and logout

    setEmail(String email){
      this.email=email;
      notifyListeners();
    }
    setPassword(String pass){
      this.password=pass;
      notifyListeners();
    }

    setAutoValidate(bool val){
      this.autoValidate=val;
      notifyListeners();
    }
    setIsVisible(bool val) {
      this.isVisible = val;
      notifyListeners();
    }

    addNewUserInfo()async{
      try{
       
        String userId=await Auth.auth.createUserUsingEmailAndPassword(this.email, this.password);
      if(userId!=null){
        
        User user=User(email: this.email,password: this.password,documentUserId: userId);
        UserClient.userClient.addNewUser(user);
        notifyListeners();
      }
      }catch(e){
        print(e);
      }
      
    }

     String validateEmail(String val){
      String message = '';
      message=isNull(val) || val == '' ? 'Email is required' : !isEmail(val)?'Invalid Email':null;
      this.message=message;
      notifyListeners();
      return this.message;
    }
     String validatePassword(String val){
      String message = '';
      message = isNull(val) || val == '' ? 'Password is required' : val.length<6? 'Password must be at least 6 characters': null;
      this.message=message;
      notifyListeners();
      return this.message;
    }

    isAdmin()async{
      String userId=await Auth.auth.signInUsingEmailAndPassword(this.email,this.password);
      User user=await UserRepository.userRepository.getUserInfo(userId);
      this.admin=user.isAdmin;
      notifyListeners();
      print(this.admin);

    }

    /*loginLogoutText()async{
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences sharedPref=await SharedPreferences.getInstance();
      String userId=sharedPref.getString("userId");
      bool isLogged=sharedPref.getBool("isLogged");
      this.isLogged=isLogged;
      notifyListeners();
    }
    */
    
}