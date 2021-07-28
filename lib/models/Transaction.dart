import 'Product.dart';

class Transaction {
  final String ip;
  final List<Product> products;

  Transaction({
    required this.ip,
    required this.products,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      ip: json['ip'],
      products: json['products'],
    );
  }
}