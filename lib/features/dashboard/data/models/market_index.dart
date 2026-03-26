import 'package:equatable/equatable.dart';

class MarketIndex extends Equatable {
  final String name;
  final String symbol;
  final double value;
  final double change;
  final double changePercent;
  final bool isPositive;

  const MarketIndex({
    required this.name,
    required this.symbol,
    required this.value,
    required this.change,
    required this.changePercent,
    required this.isPositive,
  });

  @override
  List<Object?> get props => [
    name,
    symbol,
    value,
    change,
    changePercent,
    isPositive,
  ];

  MarketIndex copyWith({
    String? name,
    String? symbol,
    double? value,
    double? change,
    double? changePercent,
    bool? isPositive,
  }) {
    return MarketIndex(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      value: value ?? this.value,
      change: change ?? this.change,
      changePercent: changePercent ?? this.changePercent,
      isPositive: isPositive ?? this.isPositive,
    );
  }
}
