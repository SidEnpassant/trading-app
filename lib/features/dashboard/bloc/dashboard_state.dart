import 'package:equatable/equatable.dart';
import 'package:trading/features/dashboard/data/models/market_index.dart';
import 'package:trading/features/dashboard/data/models/stock_brief.dart';
import 'package:trading/features/dashboard/data/models/portfolio_summary.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<MarketIndex> indices;
  final List<StockBrief> topGainers;
  final List<StockBrief> topLosers;
  final PortfolioSummary portfolioSummary;

  const DashboardLoaded({
    required this.indices,
    required this.topGainers,
    required this.topLosers,
    required this.portfolioSummary,
  });

  @override
  List<Object?> get props => [indices, topGainers, topLosers, portfolioSummary];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
