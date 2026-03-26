import 'package:equatable/equatable.dart';
import 'package:trading/features/orders/data/models/stock_brief.dart';

class Holding extends Equatable {
  final StockBrief stock;
  final int quantity;
  final double avgPrice;
  final double currentPrice;
  final double dayPnl;
  final double totalPnl;

  const Holding({
    required this.stock,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.dayPnl,
    required this.totalPnl,
  });

  @override
  List<Object?> get props => [
    stock,
    quantity,
    avgPrice,
    currentPrice,
    dayPnl,
    totalPnl,
  ];
}
