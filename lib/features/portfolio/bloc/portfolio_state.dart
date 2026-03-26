import 'package:equatable/equatable.dart';
import '../data/models/holding.dart';
import '../data/models/portfolio_pnl.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final List<Holding> holdings;
  final PortfolioPnl summary;

  const PortfolioLoaded(this.holdings, this.summary);

  @override
  List<Object?> get props => [holdings, summary];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
