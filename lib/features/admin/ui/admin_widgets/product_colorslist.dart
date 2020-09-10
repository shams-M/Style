import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class ProductColors extends StatelessWidget {
  Widget widget;
  List colorsList;
  ProductColors({this.colorsList});
  @override
  Widget build(BuildContext context) {

    return showColors(context,colorsList);
  }

  showColors(BuildContext context,List stringColorsList) {


    List<Color> colorsList = [];
    for (var item in stringColorsList) {
      String s = item.split('(0x')[1].split(')')[0];
      Color c = new Color(int.parse(s, radix: 16));
      colorsList.add(c);
    }

    if (colorsList != null && colorsList.isNotEmpty) {
      widget = SizedBox(
        height: 35,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorsList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorsList[index],
                  ));
            }),
      );
    } else {
      widget = Container();
    }
    return widget;
  }
}
