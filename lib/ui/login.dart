import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/ui/admin_home.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/ui/create_account.dart';
import 'package:style/ui/shop.dart';
import 'package:style/values/style.dart';

class Login extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldLogin = GlobalKey();



  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    UserProvider userProvider2 = Provider.of<UserProvider>(context,listen: false);
    return Scaffold(
      key: scaffoldLogin,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.0),
        child: SingleChildScrollView(
          child: Form(
            //key: userProvider.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Image.asset(
                  'assets/images/mylogo.png',
                  width: 200,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 15.0),
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: loginHeadLine,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (val) {
                    userProvider.setEmail(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: subtitle1,
                    border: UnderlineInputBorder(),
                  ),
                  //validator: userProvider.validateEmail,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: userProvider.isVisible ? false : true,
                  onChanged: (val) {
                    userProvider.setPassword(val);
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: userProvider.isVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      onPressed: () {
                        if (userProvider.isVisible == true) {
                          userProvider.setIsVisible(false);
                        } else {
                          userProvider.setIsVisible(true);
                        }
                      },
                    ),
                    labelText: 'Password',
                    labelStyle: subtitle1,
                    border: UnderlineInputBorder(),
                  ),
                  //validator: userProvider.validatePassword,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    child: Text(
                      'Login',
                      style: subtitle1.copyWith(color: Colors.white),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    width: double.infinity,
                    height: 50,
                  ),
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return AdminHome();
                    }));

                      /*if(userProvider.admin==1){

                      }
                      else{
                        Navigator.of(context).push( MaterialPageRoute(
                            builder: (context) =>
                                Shop()));
                      }*/
                      /*if(userProvider.loginFormKey.currentState.validate()){
                        userProvider.loginFormKey.currentState.save();
                        userProvider.isAdmin();


                      }*/


                  },
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account?',
                        style: subtitle1.copyWith(color: Colors.black87),
                      ),
                      SizedBox(width: 6.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                        },
                        child: Text(
                          'Sign Up',
                          style: subtitle1.copyWith(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
