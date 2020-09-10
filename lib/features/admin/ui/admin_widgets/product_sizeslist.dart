import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class ProductSizes extends StatelessWidget {
  Widget widget;
  List sizesList;
  ProductSizes({this.sizesList});
  @override
  Widget build(BuildContext context) {
    return showSizes(context, sizesList);
  }

  showSizes(BuildContext context, List sizesList) {
    if (sizesList != null && sizesList.isNotEmpty) {
      widget = SizedBox(
        height: 50,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizesList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    sizesList[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                    border: Border.all(width: 2, color: Color(0xff8D61D1))),
              );
            }),
      );
    } else {
      widget = Container();
    }
    return widget;
  }
}
