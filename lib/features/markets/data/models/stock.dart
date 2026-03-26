import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final double changePercent;
  final bool isPositive;
  final String sector;
  final double marketCap;
  final double pe;
  final double pb;
  final double dividendYield;

  const Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.isPositive,
    required this.sector,
    required this.marketCap,
    required this.pe,
    required this.pb,
    required this.dividendYield,
  });

  @override
  List<Object?> get props => [
    symbol,
    name,
    price,
    change,
    changePercent,
    isPositive,
    sector,
    marketCap,
    pe,
    pb,
    dividendYield,
  ];
}
