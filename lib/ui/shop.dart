import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/repositories/admin_repository.dart';
import 'package:style/ui/create_account.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<Category>> allCatFun() async {
      return await AdminRepository.adminRepository.getAllCategories();
    }

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffFF7B9C), Color(0xffFFC759)])),
              child: Image.asset('assets/images/mylogo.png'),
            ),
            ListTile(
              title: Text('Home'),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                    'https://firebasestorage.googleapis.com/v0/b/flutter-training-a9685.appspot.com/o/otherImgs%2Fmylogo.png?alt=media&token=68586a44-611f-4d1c-b461-47941598af41'),
                backgroundColor: Colors.green[300],
              ),
            ),
            

            /*Consumer<AdminProvider>(builder: (context, value, child) {
              List<Category> categories = value.allCategories;
              if (categories.isEmpty|| categories==null){
                 return ListTile(title: Text('No categories'),);
              }
              else{
                for (var item in categories) {
                  return ListTile(
                    title: Text(item.name),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          CachedNetworkImageProvider(item.imageUrl),
                      backgroundColor: Colors.grey[400],
                    ),
                  );
                }
              }
            }
            ),*/

            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: ListTile(
                title: Text('Create Account'),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Style'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: FutureBuilder(
            future: allCatFun(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.hashCode*0.3,
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(backgroundColor: Colors.grey[300],backgroundImage: 
                              CachedNetworkImageProvider(snapshot.data[index].imageUrl)),
                              Text(snapshot.data[index].name)
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Container(
                  height: 40,
                  child: Text('no Categ'),
                );
              }
            }),
      ),
    );
  }
}
