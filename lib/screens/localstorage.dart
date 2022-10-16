import 'package:ecom/product.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'localstorage.g.dart';

@HiveType(typeId: 0)
class cartproduct extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String imagelink;
  @HiveField(3)
  late String category;
  @HiveField(4)
  late int quantity;
  @HiveField(5)
  late int price;
}

class Boxes {
  static Box<cartproduct> getTransactions() =>
      Hive.box<cartproduct>('products');
}

Future addToCartLocal(product pro) async {
  final transaction = cartproduct()
    ..name = pro.name!
    ..category = pro.description!
    ..price = pro.price!
    ..imagelink = pro.imagelink!
    ..quantity = pro.quantity!;

  final box = Boxes.getTransactions();
  box.add(transaction);
  //box.put('mykey', transaction);

  // final mybox = Boxes.getTransactions();
  // final myTransaction = mybox.get('key');
  // mybox.values;
  // mybox.keys;
}

void editTransaction(
  cartproduct transaction,
  String name,
  double amount,
  bool isExpense,
) {
  transaction.name = name;

  // final box = Boxes.getTransactions();
  // box.put(transaction.key, transaction);

  transaction.save();
}

void deleteTransaction(cartproduct transaction) {
  // final box = Boxes.getTransactions();
  // box.delete(transaction.key);

  transaction.delete();
  //setState(() => transactions.remove(transaction));
}
