import 'package:equatable/equatable.dart';
import 'order_type.dart';
import 'order_status.dart';
import 'stock_brief.dart';

class Order extends Equatable {
  final String id;
  final StockBrief stock;
  final OrderType orderType;
  final int quantity;
  final double price;
  final OrderStatus status;
  final DateTime timestamp;

  const Order({
    required this.id,
    required this.stock,
    required this.orderType,
    required this.quantity,
    required this.price,
    required this.status,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
    id,
    stock,
    orderType,
    quantity,
    price,
    status,
    timestamp,
  ];
}
