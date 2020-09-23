import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/product_colorslist.dart';
import 'package:style/features/admin/ui/admin_widgets/product_sizeslist.dart';
import 'package:style/features/providers/cartProvider.dart';
import 'package:style/ui/widgets/Customer_product_sizeslist.dart';
import 'package:style/ui/widgets/customer_product_colorslist.dart';
import 'package:style/values/colors.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  ProductDetails({this.product});
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    //CartProvider cartProvider=Provider.of<CartProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUrl,
            height: 300,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${product.price} \$',
            style: TextStyle(
                fontSize: 20,
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          CustomerProductColors(
            colorsList: product.productColors,
          ),
          SizedBox(
            height: 10,
          ),
          CustomerProductSizes(
            sizesList: product.productSizes,
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(onTap: (){
            //cartProvider.addNewItemToCart(product);
          },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                ),

            ),
          ),
        ],
      ),
    );
  }
}
