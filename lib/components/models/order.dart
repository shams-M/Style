import 'package:style/components/models/product.dart';
import 'package:style/values/strings.dart';

class Order{
  String userId;
  String date;
  String address;
  List<Product> products;
  List<Map> productsMap;

  Order({this.userId,this.date,this.address,this.products}){
    productsMap=products.map((e) => e.toJson()).toList();
  }
  toJson(){
    return {
       oUserId:this.userId,
       oDate:this.date,
       oAddress:this.address,
       oProducts:productsMap,

    };
   

  }
  
}