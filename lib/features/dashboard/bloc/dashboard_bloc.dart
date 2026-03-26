import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trading/features/dashboard/data/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';
import '../../../../core/di/service_locator.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository = sl<DashboardRepository>();
  StreamSubscription? _indicesSubscription;

  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshMarket>(_onRefreshMarket);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final indices = await _dashboardRepository.getIndices();
      final gainers = await _dashboardRepository.getTopGainers();
      final losers = await _dashboardRepository.getTopLosers();
      final summary = await _dashboardRepository.getPortfolioSummary();

      emit(
        DashboardLoaded(
          indices: indices,
          topGainers: gainers,
          topLosers: losers,
          portfolioSummary: summary,
        ),
      );

      // Listen to real-time index updates
      _indicesSubscription?.cancel();
      _indicesSubscription = _dashboardRepository.getIndicesStream().listen((
        updatedIndices,
      ) {
        if (state is DashboardLoaded) {
          final currentState = state as DashboardLoaded;
          add(RefreshMarket());
          emit(
            DashboardLoaded(
              indices: updatedIndices,
              topGainers: currentState.topGainers,
              topLosers: currentState.topLosers,
              portfolioSummary: currentState.portfolioSummary,
            ),
          );
        }
      });
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onRefreshMarket(
    RefreshMarket event,
    Emitter<DashboardState> emit,
  ) async {
    // Refresh logic handled by stream listener
  }

  @override
  Future<void> close() {
    _indicesSubscription?.cancel();
    return super.close();
  }
}
