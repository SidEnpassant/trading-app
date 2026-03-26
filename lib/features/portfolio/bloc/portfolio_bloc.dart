import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/portfolio/data/repositories/portfolio_repository.dart';
import 'portfolio_event.dart';
import 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final PortfolioRepository _repository;

  PortfolioBloc(this._repository) : super(PortfolioInitial()) {
    on<LoadPortfolio>(_onLoadPortfolio);
    on<RefreshPortfolio>(_onRefreshPortfolio);
  }

  Future<void> _onLoadPortfolio(
    LoadPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(PortfolioLoading());
    try {
      final holdings = await _repository.getHoldings();
      final summary = await _repository.getPortfolio();
      emit(PortfolioLoaded(holdings, summary));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }

  Future<void> _onRefreshPortfolio(
    RefreshPortfolio event,
    Emitter<PortfolioState> emit,
  ) async {
    try {
      final holdings = await _repository.getHoldings();
      final summary = await _repository.getPortfolio();
      emit(PortfolioLoaded(holdings, summary));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }
}
