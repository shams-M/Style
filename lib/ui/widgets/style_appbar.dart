import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/ui/cart.dart';
import 'package:style/values/colors.dart';

class StyleAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return AppBar(
      title: Text(adminProvider.categorySelectedName),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart,color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Cart();
                  }));
                },
                iconSize: 38,

              ),
              Container(alignment: Alignment.center,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.white),
                ),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: notificationColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ],
          ),
          //SvgPicture.asset("assets/icons/add_to_cart.svg",semanticsLabel: "Cart",color: svgIconsColor,height: 32,),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(60);
  }
}
