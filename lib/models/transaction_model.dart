class TransactionModel {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  double amount;
  String kind;

  TransactionModel({
    required this.id,
    required this.createdAt,
    required this.amount,
    required this.name,
    required this.kind,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
