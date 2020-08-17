import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/custom_dropdown_button.dart';

class NewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('New Product')),
      body: Container(
        margin:
            EdgeInsets.all(10),
        child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                    onChanged: (val) {
                      adminProvider.setproductName(val);
                    },
                  ),
                ),
                SizedBox(height: 5,),
                Expanded(flex: 2,
                  child: TextField(
                    minLines: 3,
                    maxLines: 4,
                    decoration: InputDecoration(
                        labelText: 'Product Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                    onChanged: (val) {
                      adminProvider.setproductDescription(val);
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Product Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                    onChanged: (val) {
                      adminProvider.setproductPrice(val);
                    },
                  ),
                ),
                SizedBox(height: 5,),
                Expanded(
                  child: CustomDropDownButton(),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(onTap: () async {
                    PickedFile imageFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                        maxWidth: 300,
                        maxHeight: 300);
                    print(imageFile.path);
                    File file = File(imageFile.path);
                    adminProvider.setproductImgFile(file);
                    adminProvider.uploadProductImgFile();
                  }, child: Consumer<AdminProvider>(
                    builder: (context, value, child) {
                      String imageUrl = value.productImgUrl;
                      if (imageUrl == null || imageUrl == '') {
                        return Container(
                          height: 300,
                          width: 300,
                          color: Colors.grey,
                        );
                      } else {
                        adminProvider.setProductImgUrl(imageUrl);
                        return CachedNetworkImage(
                          placeholder: (context, s) => LinearProgressIndicator(
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
                SizedBox(height: 5,),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      bool result = await Provider.of<AdminProvider>(context,
                              listen: false)
                          .addNewProduct();

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
            ),
      ),
    );
  }
}
