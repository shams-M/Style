import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style/values/colors.dart';


import '../shop.dart';

class StyleAppBar extends StatelessWidget implements PreferredSizeWidget{
  String title;
  StyleAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/icons/add_to_cart.svg",semanticsLabel: "Cart",color: svgIconsColor,height: 32,),
            ),
          
          ],
    );
  }

  @override
  
  Size get preferredSize {
    return Size.fromHeight(60);
  }
}
