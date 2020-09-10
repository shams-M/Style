import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:style/features/admin/ui/admin_home.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/services/functions.dart';
import 'package:style/ui/create_account.dart';
import 'package:style/ui/shop.dart';
import 'package:style/values/colors.dart';

class Login extends StatelessWidget {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldLogin = GlobalKey();

  String email;
  String password;

  setEmail(String val) {
    this.email = val;
  }

  setPassword(String val) {
    this.password = val;
  }

  String validateEmail(String e) {
    String message = '';
    message = isNull(e) || e == ''
        ? 'Email is required'
        : !isEmail(e) ? 'Invalid Email' : '';
    return message;
  }

  String validatePassword(String p) {
    String message = '';
    message = isNull(p) || p == '' ? 'Password is required' : '';
    return message;
  }

  loginBtnClickFunc(BuildContext context) async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      bool admin = await isAdminFunc(context);
      if (admin != null && admin) {
        print('Welcome admin');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => AdminHome()));
      } else {
        print('welcome customer');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Shop()));
      }
    } else {
      print('not validate');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Scaffold(

      key: scaffoldLogin,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: loginFormKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/mylogo.png',
                        width: 150,
                        height: 150,
                      )),
                  Expanded(flex: 1, child: Text('Login')),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      onChanged: (val) {
                        userProvider.setEmail(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        userProvider.setPassword(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: ACCENT_COLOR,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      height: 50,
                    ),
                    onTap: () {
                      {
                        loginBtnClickFunc(context);
                      }
                    },
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateAccount()));
                      },
                      child: Text('New User? Create an account')),
                ],
              ),

          ),
        ),
      ),
    );
  }
}
