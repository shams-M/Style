import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/admin_product_item.dart';
import 'package:style/features/admin/ui/edit_product.dart';
import 'package:style/features/admin/ui/new_product.dart';
import 'package:style/values/colors.dart';

class AdminProducts extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKeyAdminProduct = GlobalKey();

  Future<bool> alertAdmin(
      DismissDirection direction, BuildContext context, Product p) async {
    AdminProvider adminProvider2 =
        Provider.of<AdminProvider>(context, listen: false);
    String title;
    if (direction == DismissDirection.startToEnd) {
      title = 'Delete';
    } else {
      title = 'Edit';
    }
    return await showCupertinoDialog<bool>(
            context: context,
            builder: (conttext) {
              return CupertinoAlertDialog(
                title: Text('$title Item'),
                content: Text('Do you want to $title Item'),
                actions: [
                  CupertinoDialogAction(
                    child: Text(title),
                    onPressed: () {
                      if (title == 'Delete') {
                        adminProvider2.deleteProduct(p);

                        Navigator.of(context).pop(true);
                      } else if (title == 'Edit') {
                        print(title);
                        adminProvider2.setSelectedProduct(p);
                        adminProvider2.setCname(p.categoryname);
                        adminProvider2.setColorsList(p.productColors);
                        adminProvider2.setSizesList(p.productSizes);
                        Navigator.of(context).pop(false);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return EditProduct();
                        }));
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text('Cancle'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              );
            }) ??
        false; // if the return is null it will take fale value and this means that the admin click away from dialog
  }

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
            return Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: GridView.count(
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 3,
                crossAxisCount: 2,
                children: allprod
                    .map(
                      (e) => Dismissible(
                        key: Key(e.documentId),
                        onDismissed: (direction) {},
                        confirmDismiss: (direction) {
                          alertAdmin(direction, context, e);
                        },
                        background: Container(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 45,
                          ),
                          color: deleteColor,
                          alignment: AlignmentDirectional.centerStart,
                        ),
                        secondaryBackground: Container(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 45,
                          ),
                          color: editColor,
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                        child: AdminProductItem(
                          product: e,
                        ),
                      ),
                    )
                    .toList(),
              ),
            );

          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              adminProvider.colorsList = [];
              adminProvider.sizesList = [];
              adminProvider.setSelectedProduct(null);
              return NewProduct();
            }));
          }),
    );
  }


}
