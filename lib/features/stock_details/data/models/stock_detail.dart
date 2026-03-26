import 'package:equatable/equatable.dart';
import 'package:trading/features/markets/data/models/stock.dart';

class StockDetail extends Stock {
  final double dayHigh;
  final double dayLow;
  final double open;
  final double prevClose;
  final int volume;

  const StockDetail({
    required this.dayHigh,
    required this.dayLow,
    required this.open,
    required this.prevClose,
    required this.volume,
    required super.symbol,
    required super.name,
    required super.price,
    required super.change,
    required super.changePercent,
    required super.isPositive,
    required super.sector,
    required super.marketCap,
    required super.pe,
    required super.pb,
    required super.dividendYield,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    dayHigh,
    dayLow,
    open,
    prevClose,
    volume,
  ];
}
