import 'package:equatable/equatable.dart';

class PortfolioPnl extends Equatable {
  final double totalInvestment;
  final double currentValue;
  final double dayPnl;
  final double dayPnlPercent;
  final double overallPnl;
  final double overallPnlPercent;

  const PortfolioPnl({
    required this.totalInvestment,
    required this.currentValue,
    required this.dayPnl,
    required this.dayPnlPercent,
    required this.overallPnl,
    required this.overallPnlPercent,
  });

  @override
  List<Object?> get props => [
    totalInvestment,
    currentValue,
    dayPnl,
    dayPnlPercent,
    overallPnl,
    overallPnlPercent,
  ];
}
