import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/markets/data/repositories/markets_repository.dart';
import 'package:trading/features/markets/data/models/stock_filter.dart';
import 'markets_event.dart';
import 'markets_state.dart';

class MarketsBloc extends Bloc<MarketsEvent, MarketsState> {
  final MarketsRepository _repository;

  MarketsBloc(this._repository) : super(MarketsInitial()) {
    on<LoadStocks>(_onLoadStocks);
    on<SearchStocks>(_onSearchStocks);
    on<ApplyFilter>(_onApplyFilter);
    on<ChangeSort>(_onChangeSort);
  }

  Future<void> _onLoadStocks(
    LoadStocks event,
    Emitter<MarketsState> emit,
  ) async {
    emit(MarketsLoading());
    try {
      final stocks = await _repository.getStocks();
      emit(
        MarketsLoaded(
          stocks: stocks,
          filteredStocks: stocks,
          searchQuery: '',
          activeFilter: Sector.all,
          activeSort: SortBy.changePercentDesc,
        ),
      );
    } catch (e) {
      emit(MarketsError(e.toString()));
    }
  }

  void _onSearchStocks(SearchStocks event, Emitter<MarketsState> emit) {
    if (state is MarketsLoaded) {
      final current = state as MarketsLoaded;
      final filtered = _repository.searchStocks(event.query, current.stocks);
      emit(
        current.copyWith(filteredStocks: filtered, searchQuery: event.query),
      );
    }
  }

  void _onApplyFilter(ApplyFilter event, Emitter<MarketsState> emit) {
    if (state is MarketsLoaded) {
      final current = state as MarketsLoaded;
      final filtered = _repository.applyFilter(current.stocks, event.filter);
      emit(
        current.copyWith(filteredStocks: filtered, activeFilter: event.filter),
      );
    }
  }

  void _onChangeSort(ChangeSort event, Emitter<MarketsState> emit) {
    if (state is MarketsLoaded) {
      final current = state as MarketsLoaded;
      final sorted = _repository.sortStocks(
        current.filteredStocks,
        event.sortBy,
      );
      emit(current.copyWith(filteredStocks: sorted, activeSort: event.sortBy));
    }
  }
}
