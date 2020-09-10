import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/admin/ui/admin_widgets/admin_category_item.dart';
import 'package:style/features/admin/ui/new_category.dart';

class AdminCategories extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey=GlobalKey();
  @override
  
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider=Provider.of<AdminProvider>(context, listen: false);
    adminProvider.getAllCategories();
    return Scaffold(key: scaffoldKey,
      appBar: AppBar(
        title: Text('Categories Manag'),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, adminProvider, wigdet){
            List<Category> allCateg = adminProvider.allCategories;
            if (allCateg.isEmpty) {
              return Center(child: CircularProgressIndicator(backgroundColor: Colors.pink[500],));
            } else {
              return ListView.builder(
                  itemCount: allCateg.length,
                  itemBuilder: (context, index) {
                    return AdminCategoryItem(
                      category: allCateg[index],
                    );
                  });
            }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => NewCategory()));

          }),
    );
  }

  
}
