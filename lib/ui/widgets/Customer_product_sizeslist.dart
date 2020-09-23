import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/features/providers/userProvider.dart';
import 'package:style/values/colors.dart';

class CustomerProductSizes extends StatelessWidget {
  Widget widget;

  List sizesList;
  CustomerProductSizes({this.sizesList});
  @override
  Widget build(BuildContext context) {
    return showSizes(context, sizesList);
  }

  showSizes(BuildContext context, List sizesList) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    if (sizesList != null && sizesList.isNotEmpty) {
      widget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 45,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: sizesList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      sizesList[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Color(0xff8D61D1))),
                  ),
                ]),
              );
            }),
      );
    } else {
      widget = Container();
    }
    return widget;
  }
}
