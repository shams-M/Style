import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Auth._();
  static final Auth auth = Auth._();
  FirebaseAuth fAuth = FirebaseAuth.instance;
  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initShP()async{
    if(sharedPreferences==null){
        sharedPreferences=await SharedPreferences.getInstance();
        return sharedPreferences;
    }
    else{
      return sharedPreferences;
    }
  }

Future<String>getUser() async{
 FirebaseUser firebaseUser = await fAuth.currentUser();
 if(firebaseUser!=null){
   return firebaseUser.uid;
 }else{
   return null;
 }
}
  Future<String> createUserUsingEmailAndPassword(
      String email, String password) async {
    try {
      sharedPreferences=await initShP();
      AuthResult authResult = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      String userId = authResult.user.uid;
      sharedPreferences.setString("userId", userId);
      sharedPreferences.setBool('isLogged', true);
      return userId;
    } catch (error) {
      print(error);
    }
  }

  Future<String> signInUsingEmailAndPassword(
      String email, String password) async {
    try {
      sharedPreferences=await initShP();
      AuthResult authResult = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(authResult.user != null);
      String userId = authResult.user.uid;
      sharedPreferences.setString("userId", userId);
      sharedPreferences.setBool('isLogged', true);
      return userId;
    } catch (error) {
      print(error);
    }
  }

  signOut()async {
    sharedPreferences=await initShP();
    sharedPreferences.setString("userId", '');
      sharedPreferences.setBool('isLogged', false);
    fAuth.signOut();
  }
}
