enum OrderType { market, limit }

class BuySellRequest {
  final OrderType orderType;
  final int quantity;
  final double? price;
  final bool isBuy;

  BuySellRequest({
    required this.orderType,
    required this.quantity,
    this.price,
    required this.isBuy,
  });

  BuySellRequest copyWith({
    OrderType? orderType,
    int? quantity,
    double? price,
    bool? isBuy,
  }) {
    return BuySellRequest(
      orderType: orderType ?? this.orderType,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      isBuy: isBuy ?? this.isBuy,
    );
  }
}
