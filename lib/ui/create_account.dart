import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/services/auth.dart';
import 'package:style/ui/login.dart';
import 'package:style/ui/widgets/custom_textfield.dart';
import 'package:style/values/colors.dart';
import 'package:style/values/style.dart';

class CreateAccount extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 35.0),
        child: SingleChildScrollView(
          child: Form(
              key: userProvider.createAccountFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Image.asset(
                        'assets/images/mylogo.png',
                        width: 200,
                        height: 200,
                      ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: loginHeadLine,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      onChanged: (val){
                        userProvider.setEmail(val);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: subtitle1,
                        border: UnderlineInputBorder(),
                      ),
                    validator: userProvider.validateEmail,
                    ),

                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(obscureText: userProvider.isVisible ? false : true,
                      onChanged: (val){
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
                    validator: userProvider.validatePassword,
                    ),

                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: creteAccountBtnColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      height: 50,
                    ),
                    onTap: () {
                      if(userProvider.createAccountFormKey.currentState.validate()){
                        userProvider.createAccountFormKey.currentState.save();
                        userProvider.addNewUserInfo();
                        Navigator.of(context).push( MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Login()));
                      }

                    },
                  ),
                ],
              ),
            ),
        ),
        ),
      );

  }
}
