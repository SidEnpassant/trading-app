import 'package:equatable/equatable.dart';

class StockBrief extends Equatable {
  final String symbol;
  final String name;
  final double? currentPrice;
  final double? prevClose;

  const StockBrief({
    required this.symbol,
    required this.name,
    this.currentPrice,
    this.prevClose,
  });

  @override
  List<Object?> get props => [symbol, name, currentPrice, prevClose];
}
