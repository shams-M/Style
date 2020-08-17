import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/admin_product_item.dart';
import 'package:style/features/admin/ui/new_product.dart';

class AdminProducts extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKeyAdminProduct = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllProducts();
    return Scaffold(
      key: scaffoldKeyAdminProduct,
      appBar: AppBar(
        title: Text('Products Manag.'),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, adminProvider, wigdet) {
          List<Product> allprod = adminProvider.allProducts;
          if (allprod.isEmpty) {
            return Center(
                child: CircularProgressIndicator(
              //backgroundColor: Colors.pink[500],
            ));
          } else {
            return GridView.builder(
              itemCount: allprod.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context,index){
                    return AdminProductItem(
                      product: allprod[index],
                    );
                });
            /*
              ListView.builder(
                  itemCount: allprod.length,
                  itemBuilder: (context, index) {
                    return AdminProductItem(
                      product: allprod[index],
                    );
                  });*/
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewProduct()));
          }),
    );
  }
}
