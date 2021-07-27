class Buyer {
  final String id;
  final String name;
  final int age;

  Buyer({
    required this.id,
    required this.name,
    required this.age,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) {
    return Buyer(
      id: json['id'],
      name: json['name'],
      age: json['age'],
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
