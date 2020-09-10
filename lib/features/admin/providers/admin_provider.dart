
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/repositories/admin_client.dart';
import 'package:style/features/admin/repositories/admin_repository.dart';
import 'package:style/values/strings.dart';

class AdminProvider extends ChangeNotifier{
  String categoryName;
  String categoryImgUrl;
  File catImgFile;
  List<Category> allCategories=[];

  int categorySelectedIndex = -1;        // when user select category
  setCategorySelectedIndex(int i){
    this.categorySelectedIndex=i;
    notifyListeners();
  }

  String productName;
  String productDescription;
  String productImgUrl;
  double productPrice;
  bool productIsAvailable=true;
  File productImgFile;
  String pcatName;  //  category name for product
  List<Product> allProducts=[];
  List<Product> categorizedProducts=[];
  // for product colors
  Color pikedColor=Color(0xff884588);
  Color currentColor=Color(0xff884588);
  List colorsList=[];
  String sizeValue;
  List sizesList=[];

  setCategoryName(String value){
    this.categoryName=value;
  }
  setcatImgFile(File file){
    this.catImgFile=file;
  }
  setCatImgUrl(String val){
    this.categoryImgUrl=val;
  }


  setproductName(String value){
    this.productName=value;
  }
  setproductDescription(String value){
    this.productDescription=value;
  }
  setproductPrice(String value){
    this.productPrice=double.parse(value);
  }
  setproductIsAvailable(bool value){
    this.productIsAvailable=value;
  }
  setproductImgFile(File file){
    this.productImgFile=file;
  }
  setProductImgUrl(String val){
    this.productImgUrl=val;
  }
  setPCatName(String val){
    this.pcatName=val;
    notifyListeners();
  }


  uploadCategoryImgFile()async{
    String imgUrl=await AdminClient.adminClient.uploadImage(this.catImgFile, categoriesImgsFolder);
    this.categoryImgUrl=imgUrl;
    notifyListeners();
  }
  
  getAllCategories()async{
    List<Category> categ=await AdminRepository.adminRepository.getAllCategories();
    this.allCategories=categ;
    notifyListeners();

  }
  
  Future<bool> addNewCategory()async{
    Category category=Category(name: this.categoryName,imageUrl: this.categoryImgUrl);
    String cid=await AdminClient.adminClient.addNewCategory(category);
    if(cid!=null){
      getAllCategories();
      return true;
    }
    else{
      return false;
    }
    
  }
  
  editCategory(Category category)async{
    await AdminClient.adminClient.editCategory(category);
    getAllCategories();
  }
  
  deleteCategory(String documentId)async{
    await AdminClient.adminClient.deleteCategory(documentId);
    getAllCategories();
  }


  uploadProductImgFile()async{
    String pImgUrl=await AdminClient.adminClient.uploadImage(this.productImgFile,productsImgsFolder );
    this.productImgUrl=pImgUrl;
    notifyListeners();
  }

  setPickedColor(Color c){
    this.pikedColor=c;
    notifyListeners();
  }
  setCurrentColor(){
    this.currentColor=this.pikedColor;
    colorsList.add(this.currentColor.toString());
    notifyListeners();
  }
  setSizeValue(String v){
    this.sizeValue=v;
    notifyListeners();
  }
  saveSizeVal(){
    if(this.sizeValue.isNotEmpty){
      sizesList.add(this.sizeValue);
      //this.sizeValue='';
      notifyListeners();
    }

  }



  getAllProducts()async{
  List<Product> products=await AdminRepository.adminRepository.getAllProducts();
  this.allProducts=products;
  notifyListeners();
}

getCategorizedProducts(String cname)async{
  List<Product> categProducts=await AdminRepository.adminRepository.getCategorizedProducts(cname);
  this.categorizedProducts=categProducts;
  notifyListeners();

}

  
  Future<bool> addNewProduct()async{
    Product product=Product(name: this.productName,description: this.productDescription,imageUrl: this.productImgUrl,isAvailable:this.productIsAvailable,price: this.productPrice,categoryname: this.pcatName,productColors: this.colorsList,productSizes: this.sizesList);
    String pid=await AdminClient.adminClient.addNewProduct(product);
    if(pid!=null){
      getAllProducts();
      return true;
    }
    else{
      return false;
    }
    
  }
 
  editProduct(Product product)async{
    await AdminClient.adminClient.editProduct(product);
    getAllProducts();
  }
  
  deleteProduct(String documentId)async{
    await AdminClient.adminClient.deleteProduct(documentId);
    getAllProducts();
  }

  
   
  

}