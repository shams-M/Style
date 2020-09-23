import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/ui/login.dart';
import 'package:style/ui/shop.dart';
import 'package:style/values/colors.dart';

/*
 // With SharedPreference //
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPref=await SharedPreferences.getInstance();
  String userId=sharedPref.getString("userId");
  bool isLogged=sharedPref.getBool("isLogged");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminProvider>(
            create: (context) => AdminProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: PRIMARY_COLOR, accentColor: ACCENT_COLOR),
        title: 'Style',
        home:isLogged==null?Login():Shop(),)));


}

*/
void main() {
  runApp(StyleApp());
}

class StyleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AdminProvider>(
              create: (context) => AdminProvider()),
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: PRIMARY_COLOR, accentColor: ACCENT_COLOR),
            title: 'Style',
            home: SplashScreen(
              seconds: 7,
              gradientBackground: LinearGradient(
                colors: [PRIMARY_COLOR, adminProducts, backProductColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              image: Image.asset('assets/images/mylogo.png'),
              loaderColor: Colors.white,
              photoSize: 200,
              loadingText: Text('Fun Shopping'),
              navigateAfterSeconds: Shop(),
            )));
  }
}
