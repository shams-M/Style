import 'package:flutter/material.dart';
import 'package:style/components/models/product.dart';

class CartProvider extends ChangeNotifier{
  double itemPrice;      // price of one product
  int item_count=0;       // count of one product
  int totalItemsCount=0;  // count of all items in cart
  double totalPrice=0;        // total price in cart
  List<Product> cart_products=[];

  addNewItemToCart(Product product){
    this.itemPrice=product.price;
    this.cart_products.add(product);
    this.totalItemsCount+=this.item_count;
    this.totalPrice+=product.price;
    notifyListeners();
  }
  removeItemToCart(Product product){
    this.itemPrice=product.price;
    this.cart_products.remove(product);
    this.totalItemsCount-=this.item_count;
    this.totalPrice-=product.price*this.item_count;
    notifyListeners();
  }
  increaseItem(Product product){
    this.item_count++;
    this.itemPrice+=product.price;
    this.totalItemsCount++;
    this.totalPrice+=product.price;
    notifyListeners();
  }

  decreaseItem(Product product){
    if(this.item_count>=2){
      this.item_count--;
      this.itemPrice-=product.price;
      this.totalItemsCount--;
      this.totalPrice-=product.price;
      notifyListeners();
    }

  }
}