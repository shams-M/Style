import 'package:flutter/material.dart';
import 'package:style/ui/widgets/categorries.dart';
import 'package:style/ui/widgets/style_drawer.dart';
import 'package:style/ui/widgets/style_appbar.dart';
import 'package:style/ui/shop_products.dart';

class Shop extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: StyleAppBar(),
        drawer: StyleDrawer(),
        body: Column(
          children: [
            Expanded(flex:1, child:Categories(),),
            Expanded(flex:5, child:ShopProducts(),),

          ],
        ),
    );
  }
}
