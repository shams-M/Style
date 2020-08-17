import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/features/providers/userProvider.dart';

class CustomTextField extends StatelessWidget {
  
  final String label;
  final IconData iconData;
  final Function validate;
  final Function setVal;
  //final Function setVal;
  CustomTextField({this.label,this.iconData,this.validate,this.setVal});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(prefixIcon: Icon(iconData),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),),
          validator: (val){
             validate(val);
          },
    );
  }
}

