import 'package:style/components/models/user.dart';
import 'package:style/features/admin/models/category.dart';
import 'package:style/components/models/product.dart';
import 'package:style/features/admin/repositories/admin_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminRepository{
  AdminRepository._();
  static final AdminRepository adminRepository=AdminRepository._();

  Future<List<Category>> getAllCategories()async{
    try{
      List<DocumentSnapshot> catDocSnapshot=await AdminClient.adminClient.getAllCategories();
      List<Category> categories= catDocSnapshot.map((e) => Category.fromDocumentSnapshot(e)).toList();
      return categories;
    }catch(error){
         print(error);
    }
  }

  Future<List<Product>> getAllProducts()async{
    try{
      List<DocumentSnapshot> productsDocsSnapshot=await AdminClient.adminClient.getAllProducts();
      List<Product> products=productsDocsSnapshot.map((e) => Product.fromDocumentSnapshot(e)).toList();
      return products;
    }catch(error){
      print(error);
    }
  }

Future<List<User>> getAllUsers() async {
    try {
      List<DocumentSnapshot> l = await AdminClient.adminClient.getAllUsers();
      List<User> users = l.map((e) => User.fromDocumentSnapshot(e)).toList();
      return users;
    } catch (e) {
      print(e);
    }
  }
}