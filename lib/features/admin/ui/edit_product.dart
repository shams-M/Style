import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/categories_dropdown_btn.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:style/features/admin/ui/admin_widgets/product_colorslist.dart';
import 'package:style/features/admin/ui/admin_widgets/product_sizeslist.dart';
import 'package:style/values/colors.dart';

class EditProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHieght = MediaQuery.of(context).size.height;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.setProductImgUrl(adminProvider.selectedProduct.imageUrl);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Edit Product')),
      body: Container(
        margin: EdgeInsets.all(5),
        child: ListView(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

          children: <Widget>[

              TextFormField(initialValue: adminProvider.selectedProduct.name,
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

              TextFormField(initialValue: adminProvider.selectedProduct.description,
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
             SizedBox(height: 8,),

             TextFormField(initialValue:'${adminProvider.selectedProduct.price}',
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
             GestureDetector(
                onTap: ()async{
                  PickedFile imageFile = await ImagePicker().getImage(
                      source: ImageSource.gallery,
                      maxWidth: 200,
                      maxHeight: 200);
                  File file = File(imageFile.path);
                  adminProvider.setproductImgFile(file);
                  adminProvider.uploadProductImgFile();
                  print(adminProvider.selectedProduct.imageUrl);
                  if(adminProvider.selectedProduct.imageUrl!=null){
                    adminProvider.setProductImgUrl(adminProvider.selectedProduct.imageUrl);
                  }
                },
                child: Consumer<AdminProvider>(builder: (context,value,widget){

                  return CachedNetworkImage(placeholder:(context,srt) =>LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    value: 5,),imageUrl: value.productImgUrl,height: 200,width: 200,);

                },),
              ),

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
                  icon: Image.asset('assets/images/sizes.jpg'),iconSize: 40,tooltip: 'Choose Product Sizes',
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
                onTap: ()async{
                  await Provider.of<AdminProvider>(context, listen: false).editProduct();
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
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

          ],
        ),
      ),
    );
  }
}
