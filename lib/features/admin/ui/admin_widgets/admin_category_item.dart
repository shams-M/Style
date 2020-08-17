import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class AdminCategoryItem extends StatelessWidget {
  Category category;
  AdminCategoryItem({this.category});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        onDismissed: (direction) {
          Provider.of<AdminProvider>(context, listen: false)
              .deleteCategory(category.documentId);
        },
        key: UniqueKey(),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: CachedNetworkImageProvider(category.imageUrl),
            ),
            title: Text(category.name),
            trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //PaintingBinding.instance.imageCache.clear();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditCategory(this.category);
                  }));
                }),
          ),
        ));
  }
}

class EditCategory extends StatelessWidget {
  Category category;
  EditCategory(this.category);
  
  @override
  Widget build(BuildContext context) {
    String cimgUrl;
    double screenHieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
        adminProvider.setCatImgUrl(category.imageUrl);
    return Scaffold(
        appBar: AppBar(title: Text('Edit Category')),
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
                    child: TextFormField(
                      initialValue: category.name,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35))),
                      onChanged: (val) {
                        category.name = val;
                        //adminProvider.setCategoryName(val);
                      },
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: ()async{
                        PickedFile imageFile = await ImagePicker().getImage(
                            source: ImageSource.gallery,
                            maxWidth: 300,
                            maxHeight: 300);
                        File file = File(imageFile.path);
                        adminProvider.setcatImgFile(file);
                       adminProvider.uploadCategoryImgFile();
                       if(adminProvider.categoryImgUrl!=null){
                         adminProvider.setCatImgUrl(adminProvider.categoryImgUrl);
                       } 
                      },
                      child: Consumer<AdminProvider>(builder: (context,value,widget){
                          
                            return CachedNetworkImage(placeholder:(context,srt) =>CircularProgressIndicator(value: 10,),imageUrl: value.categoryImgUrl,height: 300,width: 300,);

                      },),
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        category.imageUrl=adminProvider.categoryImgUrl;
                        Provider.of<AdminProvider>(context, listen: false)
                            .editCategory(category);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: screenHieght * 0.02,
                        child: Text(
                          'Update',
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
