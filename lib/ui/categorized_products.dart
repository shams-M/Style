import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/ui/widgets/categorries.dart';
import 'package:style/ui/widgets/shop_product_item.dart';

class CategorizedProducts extends StatelessWidget {
  String catName;
  CategorizedProducts({this.catName});
  @override
  Widget build(BuildContext context) {

    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getCategorizedProducts(catName);
    return Consumer<AdminProvider>(
      builder: (context, myadminProvider, wigdet) {
        List<Product> categProd = myadminProvider.categorizedProducts;

        if (categProd.isEmpty || categProd == null) {
          return Center(
              child: CircularProgressIndicator(
                //backgroundColor: Colors.pink[500],
              ));
        } else {
          return GridView.builder(
              itemCount: categProd.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ShopProductItem(
                  product: categProd[index],
                );
              });
        }
      },
    );

  }
}
