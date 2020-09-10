import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:style/components/models/product.dart';
import 'package:style/ui/product_details.dart';
import 'package:style/values/colors.dart';

class ShopProductItem extends StatelessWidget {
  final Product product;

  const ShopProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double height2 = height1 - padding.top - padding.bottom;
    return GestureDetector(onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return ProductDetails(product: product,);
      }));
    },child: Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
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
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              product.name,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('${product.price} \$', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),


    ),);


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
