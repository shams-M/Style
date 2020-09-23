import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/categories_dropdown_btn.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:style/features/admin/ui/admin_widgets/product_colorslist.dart';
import 'package:style/features/admin/ui/admin_widgets/product_sizeslist.dart';


class NewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.of(context).size.height;


    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);

    return Scaffold(
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('New Product')),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            children: <Widget>[
               TextFormField(key: ValueKey('pName'),
                  decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35))),
                 onChanged: (val) {
                   adminProvider.setproductName(val);
                 },

                ),

              SizedBox(
                height: 8,
              ),
              TextFormField(key: ValueKey('pDesc'),
                  minLines: 5,
                  maxLines: 6,
                  decoration: InputDecoration(
                      labelText: 'Product Description',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35))),
                  onChanged: (val) {
                    adminProvider.setproductDescription(val);
                  },

                ),
              SizedBox(height: 8,),
               TextFormField(key: ValueKey('pPrice'),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Product Price',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35))),
                  onChanged: (val) {
                    adminProvider.setproductPrice(val);
                  },

                ),

              SizedBox(
                height: 5,
              ),
              CategoriesDropdownButton(),
              SizedBox(height: 5,),
              GestureDetector(onTap: () async {
                  PickedFile imageFile = await ImagePicker().getImage(
                      source: ImageSource.gallery, maxWidth: 200, maxHeight: 200);
                  File file = File(imageFile.path);
                  adminProvider.setproductImgFile(file);
                  adminProvider.uploadProductImgFile();
                }, child: Consumer<AdminProvider>(
                  builder: (context, value, child) {
                    String imageUrl = value.productImgUrl;
                    if (imageUrl == null || imageUrl == '') {
                      return Container(
                        height: 200,
                        width: 200,
                        color: Colors.grey,
                      );
                    } else {
                      adminProvider.setProductImgUrl(imageUrl);
                      return CachedNetworkImage(
                        placeholder: (context, s) => LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                          value: 5,
                        ),
                        imageUrl: imageUrl,
                        height: 300,
                        width: 300,
                      );
                    }
                  },
                )),

              SizedBox(
                height: 5,
              ),
              IconButton(
                    icon: SvgPicture.asset('assets/icons/choose_color.svg'),iconSize: 40,tooltip: 'Choose Product Clolors',
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: adminProvider.pikedColor,
                              onColorChanged: (color) {
                                adminProvider.setPickedColor(color);
                                // Navigator.of(context).pop();
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Got it'),
                              onPressed: () {
                                adminProvider.setCurrentColor();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }),

              ProductColors(colorsList: Provider.of<AdminProvider>(context).colorsList),

              SizedBox(
                height: 12,
              ),
              IconButton(
                    icon: Image.asset('assets/images/sizes.jpg'),iconSize: 40,tooltip: 'Choose Product Clolors',
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        child: AlertDialog(
                          title: const Text("Enter product size"),
                          content: SingleChildScrollView(
                            child:
                            TextFormField(initialValue: '',
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),labelText: "Ex: XXL , 45"),
                              onChanged: (v) {
                                adminProvider.setSizeValue(v);

                              },
                            ),


                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Save'),
                              onPressed: () {
                                adminProvider.saveSizeVal();
                                Navigator.of(context).pop();
                              },
                            ),

                          ],
                        ),
                      );
                    }),

              ProductSizes(sizesList: Provider.of<AdminProvider>(context).sizesList),
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                  onTap: () async {

                        await Provider.of<AdminProvider>(context, listen: false).addNewProduct();
                        Navigator.of(context).pop();


                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 45,
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

            ],
          ),
        ),
      ),
    );
  }
}
