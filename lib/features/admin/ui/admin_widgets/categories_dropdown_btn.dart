import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/values/colors.dart';

class CategoriesDropdownButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen: false);
    String cname=adminProvider.cname;
    return DropdownButtonFormField(key: ValueKey('pcgory'),
      items: Provider.of<AdminProvider>(context)
          .allCategories
          .map((e) => DropdownMenuItem(
                child: Text(e.name),
                value: e.name,
              ))
          .toList(),
      onChanged: (val) {
        Provider.of<AdminProvider>(context, listen: false).setPCatName(val);
        Provider.of<AdminProvider>(context, listen: false).setCname(null);

      },
      //validator: (val)=>adminProvider.validatePND(val, 'Category Name'),
      value: cname==''?Provider.of<AdminProvider>(context).pcatName:Provider.of<AdminProvider>(context).cname,
    );
  }
}
