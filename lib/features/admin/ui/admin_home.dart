import 'package:flutter/material.dart';
import 'package:style/features/admin/ui/admin_orders.dart';
import 'package:style/features/admin/ui/admin_products.dart';
import 'package:style/features/admin/ui/admin_widgets/custom_gester_detectoe.dart';
import 'package:style/values/colors.dart';

import 'admin_categories.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Style'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Row(
              children: <Widget>[
                Expanded(child:CustomGesterDetector(widget: AdminCategories(),color: adminCategories,text: 'Categories',),),
                Expanded(child: CustomGesterDetector(widget: AdminProducts(),color: adminProducts,text: 'Products',),),
              ],
            ),
            Row(
              children: <Widget>[
                  Expanded(child: CustomGesterDetector(widget: AdminOrders(),color: adminOrders,text: 'Orders',),),
                  Expanded(child: CustomGesterDetector(widget: AdminOrders(),color: adminUsers,text: 'Users',),),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
