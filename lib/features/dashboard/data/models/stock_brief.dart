import 'package:equatable/equatable.dart';

class StockBrief extends Equatable {
  final String symbol;
  final String name;
  final double currentPrice;
  final double? prevClose;
  final double? change;
  final double? changePercent;
  final bool? isPositive;

  StockBrief({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    this.prevClose,
    this.change,
    this.changePercent,
    this.isPositive,
  });

  @override
  List<Object?> get props => [
    symbol,
    name,
    currentPrice,
    prevClose,
    change,
    changePercent,
    isPositive,
  ];
}
