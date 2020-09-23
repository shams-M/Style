
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
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

  String categorySelectedName='';  // when user select category


  String productName='';
  String productDescription='';
  String productImgUrl;
  double productPrice=0;
  bool productIsAvailable=true;
  File productImgFile;
  String pcatName; //  category name for product
  String cname=''; /// for edit product to show it in dropDownButton
  List<Product> allProducts=[];
  // for product colors
  Color pikedColor=Color(0xff884588);
  Color currentColor=Color(0xff884588);
  List colorsList=[];
  String sizeValue;
  List sizesList=[];
  Product selectedProduct;

  GlobalKey<FormState> newProducFormtKey=GlobalKey();


  setCategoryName(String value){
    this.categoryName=value;
  }
  setcatImgFile(File file){
    this.catImgFile=file;
  }
  setCatImgUrl(String val){
    this.categoryImgUrl=val;
  }

  setCategorySelectedName(String v){
    this.categorySelectedName=v;
    notifyListeners();
  }


  setproductName(String value){
    this.productName=value;
    notifyListeners();
  }
  setproductDescription(String value){
    this.productDescription=value;
    notifyListeners();
  }
  setproductPrice(String value){
    this.productPrice=double.parse(value);
    notifyListeners();
  }
  setproductIsAvailable(bool value){
    this.productIsAvailable=value;
    notifyListeners();
  }
  setproductImgFile(File file){
    this.productImgFile=file;
    notifyListeners();
  }
  setProductImgUrl(String val){
    this.productImgUrl=val;
    notifyListeners();
  }
  setPCatName(String val){
    this.pcatName=val;
    notifyListeners();
  }
  setCname(String val){
    this.cname=val;
    notifyListeners();
  }
  setSelectedProduct(Product p){
    this.selectedProduct=p;
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
  
  deleteCategory(Category category)async{
    await AdminClient.adminClient.deleteCategory(category);
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
  setColorsList(List cl){
    this.colorsList=cl;
    notifyListeners();
  }
  removeItemFromColorList(int index){
    this.colorsList.removeAt(index);
    notifyListeners();
  }

  setSizeValue(String v){
    this.sizeValue=v;
    notifyListeners();
  }
  setSizesList(List sl){
    this.sizesList=sl;
    notifyListeners();
  }
  removeItemFromSizeList(int index){
    this.sizesList.removeAt(index);
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
    if(this.categorySelectedName==''){
      List<Product> products1=await AdminRepository.adminRepository.getAllProducts();
      this.allProducts=products1;
    }
    else{
      List<Product> products2=await AdminRepository.adminRepository.getCategorizedProducts(this.categorySelectedName);
      this.allProducts=products2;
    }

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
 
  editProduct()async{
    Product product=Product(documentId: selectedProduct.documentId,name: this.productName,description: this.productDescription,imageUrl: this.selectedProduct.imageUrl,isAvailable:this.productIsAvailable,price: this.productPrice,categoryname: this.pcatName,productColors: this.colorsList,productSizes: this.sizesList);
    await AdminClient.adminClient.editProduct(product);
    print(product);
    getAllProducts();
  }
  
  deleteProduct(Product product)async{
    await AdminClient.adminClient.deleteProduct(product);
    getAllProducts();
  }

  String validatePND(String val,String labelname){  // validate for product name or product description
    String message = '';
    message = isNull(val) || val == '' ? '$labelname is required' : null;
    notifyListeners();
    return message;
  }
  String validatePrice(String val,String labelname){
    String message = '';
    message = isNull(val) || val == '' ? '$labelname is required' : !isNumeric(val)?'$labelname must be number':null;
    notifyListeners();
    return message;

  }


  
   
  

}