import 'package:flutter/material.dart';

class CustomGesterDetector extends StatelessWidget{
  Widget widget;
  Color color;
  String text;
  CustomGesterDetector({this.widget,this.color,this.text});
  setWidget(Widget wedg){
    this.widget=wedg;
  }
  setColor(Color c){
    this.color=c;
  }
  setText(String t){
    this.text=t;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return this.widget;
              }));
            },
              child: Card(color: this.color,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(alignment: Alignment.center,constraints: BoxConstraints.expand(height: 200),
              child: Text(this.text,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),),
            ),
            
            );
            
  }

}