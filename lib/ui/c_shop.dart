import 'package:flutter/material.dart';
import 'package:style/ui/categorized_products.dart';
import 'package:style/ui/widgets/categorries.dart';
import 'package:style/ui/widgets/style_drawer.dart';
import 'package:style/ui/widgets/style_appbar.dart';
import 'package:style/ui/shop_products.dart';

class C_Shop extends StatelessWidget {
  String cName;
  C_Shop({this.cName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: StyleAppBar(title: cName,),
        drawer: StyleDrawer(),
        body: Column(
          children: [
            Expanded(flex:1, child:Categories(),),
            Expanded(flex:5, child:CategorizedProducts(catName: cName,),),

          ],
        ));
  }
}
