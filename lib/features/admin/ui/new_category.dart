import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class NewCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: Text('New Category')),
        body: Container(
          margin: EdgeInsets.fromLTRB(
              20, screenHieght * 0.1, 20, screenHieght * 0.1),
          height: screenHieght * 0.75,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 20, 14, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          labelText: 'Category Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35))),
                      onChanged: (val) {
                        adminProvider.setCategoryName(val);
                      },
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(onTap: () async {
                      PickedFile imageFile = await ImagePicker().getImage(
                          source: ImageSource.gallery,
                          maxWidth: 300,
                          maxHeight: 300);
                      File file = File(imageFile.path);
                      print(imageFile.path);
                      adminProvider.setcatImgFile(file);
                      adminProvider.uploadCategoryImgFile();
                    }, child: Consumer<AdminProvider>(
                      builder: (context, value, child) {
                        String imageUrl = value.categoryImgUrl;
                        if (imageUrl == null || imageUrl == '') {
                          return Container(
                            height: 300,
                            width: 300,
                            color: Colors.grey,
                          );
                        } else {
                          adminProvider.setCatImgUrl(imageUrl);
                          return CachedNetworkImage(
                            placeholder: (context, s) =>
                                LinearProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.pink),
                              value: 5,
                            ),
                            imageUrl: imageUrl,
                            height: 300,
                            width: 300,
                          );
                        }
                      },
                    )),
                  ),
                  Spacer(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        bool result = await Provider.of<AdminProvider>(context,
                                listen: false)
                            .addNewCategory();

                        print(result);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: screenHieght * 0.02,
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green[600]),
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
