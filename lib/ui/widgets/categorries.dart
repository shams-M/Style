import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/ui/c_shop.dart';
import 'package:style/ui/categorized_products.dart';
import 'package:style/ui/shop_products.dart';

import '../../values/colors.dart';

// We need satefull widget for our categories

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllCategories();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child:
          Consumer<AdminProvider>(builder: (context, myadminProvider, wigdet) {
        List<Category> cat = myadminProvider.allCategories;
        if (cat.length == 0) {
          return Container(
            //height: 60,
            child: Text('no Categ'),
          );
        } else {
          return SizedBox(
              height: 60,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cat.length,
                  itemBuilder: (context, index) {
                    return Container(margin: EdgeInsets.only(left:15,right:15),child:GestureDetector(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                backgroundImage: CachedNetworkImageProvider(
                                    cat[index].imageUrl)),
                            Text(
                              cat[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    adminProvider.categorySelectedIndex == index
                                        ? selectedTextColor
                                        : unselectedTextColor,
                              ),
                            ),
                          ]),
                      onTap: () {
                        adminProvider.setCategorySelectedIndex(index);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return C_Shop(cName: cat[index].name,);
                        }));

                      },
                    ));
                  }));
        }
      }),
    );
  }
}
