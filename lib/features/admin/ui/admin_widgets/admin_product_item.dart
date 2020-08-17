import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class AdminProductItem extends StatelessWidget {
  Product product;
  AdminProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        onDismissed: (direction) {
          Provider.of<AdminProvider>(context, listen: false)
              .deleteCategory(product.documentId);
        },
        key: UniqueKey(),
        child: Card(

          child: Container(
            height: 50,
            child: Text(product.name),

          ),
          /*ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: CachedNetworkImageProvider(product.imageUrl),
            ),
            title: Text(product.name),
            trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditProduct(this.product);
                  }));
                }),
          ),*/
        ));
  }
}


