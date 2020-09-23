import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/values/strings.dart';
import 'package:style/values/colors.dart';

import '../login.dart';
import '../shop.dart';

class StyleDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllCategories();
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Image.asset(styleLogo),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [gradientColor1, gradientColor2]))),
          ListTile(
            leading: Icon(Icons.home,size: 20,),

            title: Text(
              "Home",

            ),
            onTap: (){
              adminProvider.setCategorySelectedName('');
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Shop();
              }));
            },
          ),
          ListTile(
            title: Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Consumer<AdminProvider>(
            builder: (context, prov, wedg) {
              List<Category> cl = prov.allCategories;
              Widget w;
              if (cl.isEmpty) {
                w = ListTile(
                  title: Text("Loading..."),
                );
              } else {
                w = Column(
                  children: cl
                      .map(
                        (e) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                                CachedNetworkImageProvider(e.imageUrl),
                          ),
                          title: Text(e.name,style: TextStyle(color: adminProvider.categorySelectedName==e.name?selectedTextColor:unselectedTextColor),),
                          onTap: () {
                            adminProvider.setCategorySelectedName(e.name);
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return Shop();
                            }));
                          },
                        ),
                      )
                      .toList(),
                );
              }
              return w;
            },
          ),
          Container(
            height: 1,
            color: ACCENT_COLOR,
          ),
          ListTile(

            title: Text("Login"),
            leading: Icon(
              Icons.account_circle,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Login();
              }));
            },
          ),
        ],
      ),
    );
  }
}
