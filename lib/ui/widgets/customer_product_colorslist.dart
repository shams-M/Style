import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/values/colors.dart';

class CustomerProductColors extends StatelessWidget {
  Widget widget;
  List colorsList;
  CustomerProductColors({this.colorsList});
  @override
  Widget build(BuildContext context) {
    return showColors(context, colorsList);
  }

  showColors(BuildContext context, List stringColorsList) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    UserProvider userProvider=Provider.of<UserProvider>(context,listen: false);

    List<Color> colorsList = [];
    for (var item in stringColorsList) {
      String s = item.split('(0x')[1].split(')')[0];
      Color c = new Color(int.parse(s, radix: 16));
      colorsList.add(c);
    }

    if (colorsList != null && colorsList.isNotEmpty) {
      widget = Container(
        decoration: BoxDecoration(
          color: userProvider.admin==true?Colors.grey[200]:null,
          borderRadius: BorderRadius.circular(8),
        ),
        height: userProvider.admin==true?88:45,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorsList.length,
            itemBuilder: (context, index) {
              return  Container(padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                  child: Column(
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorsList[index],
                          )),
                      userProvider.admin==true?IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          color: deleteColor,
                          onPressed: () {
                            adminProvider.removeItemFromColorList(index);
                          }):Container(width: 0,height: 0,),
                    ],
                  ),
                )
              ;
            }),
      );
    } else {
      widget = Container();
    }
    return widget;
  }
}
