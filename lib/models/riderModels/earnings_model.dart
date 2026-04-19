
class EarningsModel {
  final double totalEarnings;
  final int rideCompleted;
  final double commission;
  final double cashReceived;
  final double balance;
  final List<EarningTransaction> transactions;

  EarningsModel({
    this.totalEarnings = 0.0,
    this.rideCompleted = 0,
    this.commission = 0.0,
    this.cashReceived = 0.0,
    this.balance = 0.0,
    this.transactions = const [],
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'] ?? {};
    return EarningsModel(
      totalEarnings: _toDouble(summary['totalEarnings']),
      rideCompleted: _toInt(summary['ridesCompleted']),
      commission: _toDouble(summary['totalCommission']),
      cashReceived: _toDouble(summary['cashReceived']),
      balance: _toDouble(json['balance']), // Keeping if balance exists in root
      transactions: json['transactions'] != null
          ? List<EarningTransaction>.from(
              json['transactions'].map((x) => EarningTransaction.fromJson(x)))
          : [],
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class EarningTransaction {
  final String id;
  final String title;
  final String createdAt;
  final double amount;
  final String paymentMethod;
  final String type; 

  EarningTransaction({
    this.id = '',
    this.title = '',
    this.createdAt = '',
    this.amount = 0.0,
    this.paymentMethod = '',
    this.type = '',
  });

  factory EarningTransaction.fromJson(Map<String, dynamic> json) {
    return EarningTransaction(
      id: json['transactionId'] ?? '',
      title: json['userName'] ?? '',
      createdAt: json['date'] ?? '',
      amount: _toDouble(json['amount']),
      paymentMethod: json['paymentMethod'] ?? '',
      type: json['type'] ?? 'credit', // Defaulting to credit as per common usage
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
