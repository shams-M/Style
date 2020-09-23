import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:style/components/models/product.dart';
import 'package:style/values/colors.dart';

class CartItem extends StatelessWidget {
   final Product product;
  CartItem({this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
            ),),
            Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              Text(product.name),
              Text('${product.price} \$ '),
            ],),),
            Expanded(child: Row(
              children: [
                Expanded(child: Column(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_drop_up,size: 30,), onPressed: (){}),
                    Text('1'),
                    IconButton(icon: Icon(Icons.arrow_drop_down,size: 30,), onPressed: (){}),
                  ],
                ),),
                Expanded(child: IconButton(icon: Icon(Icons.remove_circle_outline,size: 27,color: notificationColor,),onPressed: (){},),)
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
