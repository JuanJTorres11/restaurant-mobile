import 'Transaction.dart';

class Buyer {
  final String? id;
  final String name;
  final int age;
  final List<Transaction>? transactions;

  Buyer({
    this.id,
    required this.name,
    required this.age,
    this.transactions
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      transactions: json['transactions']
    );
  }
}

class QueryBuyer {
  final List buyers;

  QueryBuyer({
    required this.buyers,
  });

  factory QueryBuyer.fromJson(Map<String, dynamic> json) {
    return QueryBuyer(
      buyers: json['queryBuyer'],
    );
  }
}

class GetBuyerQuery {
  final Buyer buyer;
  final List<String> otherBuyers;
  final List<String> recommendedProducts;

  GetBuyerQuery({
    required this.buyer,
    required this.otherBuyers,
    required this.recommendedProducts,
  });

  factory GetBuyerQuery.fromJson(Map<String, dynamic> json) {
    return GetBuyerQuery(
      buyer: json['Buyer']['getBuyer'],
      otherBuyers: json['Other_Buyers'],
      recommendedProducts: json['Recommended_Products'],
    );
  }
}
