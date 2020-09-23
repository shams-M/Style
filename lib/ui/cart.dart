import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/providers/cartProvider.dart';
import 'package:style/ui/widgets/cart_item.dart';
import 'package:style/ui/widgets/style_drawer.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        drawer: StyleDrawer(),
        body: Container(width: 0,height: 0,)
      );

  }
}
