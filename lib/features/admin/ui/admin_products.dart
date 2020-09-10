import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/admin_product_item.dart';
import 'package:style/features/admin/ui/new_product.dart';
import 'package:style/values/colors.dart';

class AdminProducts extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKeyAdminProduct = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllProducts();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: scaffoldKeyAdminProduct,
      appBar: AppBar(
        title: Text('Products Manag.'),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, myadminProvider, wigdet) {
          List<Product> allprod = myadminProvider.allProducts;
          if (allprod.isEmpty || allprod == null) {
            return Center(
                child: CircularProgressIndicator(
                    //backgroundColor: Colors.pink[500],
                    ));
          } else {
            return GridView.count(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2 / 3,
              crossAxisCount: 2,
              children: allprod
                  .map(
                    (e) => Dismissible(
                      key: Key(e.documentId),
                      onDismissed: (direction) {
                        myadminProvider.deleteProduct(e.documentId);
                        scaffoldKeyAdminProduct.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'The product has been removed successfully')));
                      },
                      background: Container(
                        color: deleteColor,
                      ),
                      child: AdminProductItem(
                        product: e,
                      ),
                    ),
                  )
                  .toList(),
            );
            /*GridView.builder(
                itemCount: allprod.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final p = allprod[index];
                  return Dismissible(
                    key: Key(p.documentId),
                    onDismissed: (direction) {
                      myadminProvider.deleteProduct(p.documentId);
                      scaffoldKeyAdminProduct.currentState.showSnackBar(SnackBar(
                          content: Text(
                              'The product has been removed successfully')));
                    },
                    background: Container(
                      color: deleteColor,
                    ),
                    child: AdminProductItem(
                      product: p,
                    ),
                  );
                });*/
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              adminProvider.colorsList=[];
              adminProvider.sizesList=[];
              return NewProduct();
            }));
          }),
    );
  }
}
