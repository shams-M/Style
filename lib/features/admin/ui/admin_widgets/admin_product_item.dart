import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class AdminProductItem extends StatelessWidget {
  final Product product;

  const AdminProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: Container(
            //height: 600,
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(
                  height: 143,
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border:Border.all(width: 1,color: Colors.grey[400]),
                        image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    )),
                  )),
            ),
            SizedBox(
              height: 50,
              child: Text(
                product.name,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 50,
              child:
                  Text('${product.price} \$', style: TextStyle(fontSize: 16)),
            ),
          ],
        )));
    /*Card(
      child: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            Flexible(fit:FlexFit.tight,
              flex: 1,
              child: Text(
                product.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Flexible(fit:FlexFit.tight,
              flex: 1,
              child:
                  Text('${product.price} \$', style: TextStyle(fontSize: 20)),
            ),
            Flexible(fit:FlexFit.loose,
              flex: 1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        print('edit product');
                      }),
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        print('remove product');
                      })
                ],
              ),
            )
          ],
        ),
      ),

    );
  */
    /* return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.asset(product.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20 / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product.price}",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ); */
  }
}
