import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/ui/widgets/categorries.dart';
import 'package:style/ui/widgets/shop_product_item.dart';

class ShopProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllProducts();
    return Consumer<AdminProvider>(
      builder: (context, myadminProvider, wigdet) {
        List<Product> allprod = myadminProvider.allProducts;
        if (allprod.isEmpty || allprod == null) {
          return Center(
              child: CircularProgressIndicator(
                  //backgroundColor: Colors.pink[500],
                  ));
        } else {
          return GridView.builder(
              itemCount: allprod.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return ShopProductItem(
                  product: allprod[index],
                );
              });
        }
      },
    );
  }
}
