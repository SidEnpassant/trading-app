import 'package:equatable/equatable.dart';
import 'package:trading/features/dashboard/data/models/market_index.dart';
import 'package:trading/features/dashboard/data/models/stock_brief.dart';
import 'package:trading/features/dashboard/data/models/portfolio_summary.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class RefreshMarket extends DashboardEvent {}
