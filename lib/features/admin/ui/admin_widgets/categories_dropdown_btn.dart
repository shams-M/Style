import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';

class CategoriesDropdownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    //List<DropdownMenuItem<dynamic>> categoriesItems = [];
    /*
    categoriesItems = [
      DropdownMenuItem(
          child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: CachedNetworkImageProvider(allcat[0].imageUrl),
        ),
        title: Text(allcat[0].name),
      )),
      DropdownMenuItem(
          child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: CachedNetworkImageProvider(allcat[0].imageUrl),
        ),
        title: Text(allcat[0].name),
      )),
    ];
    */
    return DropdownButton(
        items: Provider.of<AdminProvider>(context)
            .allCategories
            .map((e) => DropdownMenuItem(
                  child: Text(e.name),value: e.name,
                ))
            .toList(),
        onChanged: (val) {
          Provider.of<AdminProvider>(context,listen: false).setPCatName(val);
        },
      value: Provider.of<AdminProvider>(context).pcatName,
        );
  }
}
