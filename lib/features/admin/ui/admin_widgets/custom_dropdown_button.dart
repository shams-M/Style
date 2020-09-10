import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/features/admin/providers/admin_provider.dart';
import 'package:style/values/colors.dart';

class CustomDropDownButton extends StatefulWidget {
  
  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  // Default Drop Down Item.
  String dropdownValue = 'Clothes';
  
 
  // To show Selected Item in Text.
  String holder = '' ;
  List <String> catgName = [];
 
  /*List <String> catgName = [
    'Clothes', 
    'Jewellery', 
    'HandBags', 
    'Shoes', 
    ] ;*/
 
  void getDropDownItem(){
 
    setState(() {
      holder = dropdownValue ;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider=Provider.of<AdminProvider>(context,listen:false);
    adminProvider.getAllCategories();
    List<Category> categ=adminProvider.allCategories;
    for (var item in categ) {
      catgName.add(item.name);
    }
    return Scaffold(
      body: Center(
        child :
        Column(children: <Widget>[
 
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: PRIMARY_COLOR, fontSize: 18),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (val) {
              setState(() {
                dropdownValue = val;
                adminProvider.setPCatName(val);
              });
            },
            items: catgName.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
                     
        ]),
      ),
    );
  }
  
   /* AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false).getAllCategories();
    List<Category> allcat = adminProvider.allCategories;
    List<String> catNames = List();
    List<String> catIds = List();
    DropdownMenuItem dropdownMenuItem;
    List<DropdownMenuItem> listDropdownMenuItem = List();
    List<DropdownMenuItem> getcatNamesForDDB(){
      for (var i = 0; i < allcat.length; i++) {
      catNames.add(allcat[i].name);
      dropdownMenuItem = DropdownMenuItem(
        child: Text(catNames[i]),
        value: catNames[i],
      );
      listDropdownMenuItem.add(dropdownMenuItem);
    }
    return listDropdownMenuItem;
    } */

  
}
