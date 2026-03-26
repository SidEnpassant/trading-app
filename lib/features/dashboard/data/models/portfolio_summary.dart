import 'package:equatable/equatable.dart';

class PortfolioSummary extends Equatable {
  final double totalValue;
  final double dayPnl;
  final double overallPnl;
  final List<AllocationData> allocation;

  const PortfolioSummary({
    required this.totalValue,
    required this.dayPnl,
    required this.overallPnl,
    required this.allocation,
  });

  @override
  List<Object?> get props => [totalValue, dayPnl, overallPnl, allocation];
}

class AllocationData {
  final String label;
  final double value;
  final String color; // hex color

  AllocationData({
    required this.label,
    required this.value,
    required this.color,
  });
}
