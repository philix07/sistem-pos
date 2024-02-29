import 'dart:convert';

class History {
  final String id;
  final String paymentMethod;
  final int totalPayment;
  final DateTime transactionDate;

  History({
    required this.id,
    required this.paymentMethod,
    required this.totalPayment,
    required this.transactionDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paymentMethod': paymentMethod,
      'totalPayment': totalPayment,
      'transactionDate': transactionDate,
    };
  }

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'] as String,
      paymentMethod: map['paymentMethod'] as String,
      totalPayment: map['totalPayment'] as int,
      transactionDate: map['transactionDate'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory History.fromJson(String source) =>
      History.fromMap(json.decode(source) as Map<String, dynamic>);
}
