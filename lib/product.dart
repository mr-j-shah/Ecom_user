import 'package:cloud_firestore/cloud_firestore.dart';

class product {
  String? name, description, imagelink, category;
  int? quantity, price;
  bool isFavourite = false;
  product.fromDocument(DocumentSnapshot d, String s) {
    final data = d.data()! as Map<String, dynamic>;
    name = data['Name'];
    description = data['Description'];
    quantity = data['Quantity'];
    price = data['Price'];
    imagelink = data['Image'];
    category = s;
  }
  product.fromCart(DocumentSnapshot d) {
    final data = d.data()! as Map<String, dynamic>;
    name = data['Name'];
    description = data['Description'];
    quantity = data['Quantity'];
    price = data['Price'];
    imagelink = data['Image'];
    category = data['category'];
  }
}
