import 'package:equatable/equatable.dart';
import 'package:trading/features/markets/data/models/stock.dart';
import 'package:trading/features/markets/data/models/stock_filter.dart';

abstract class MarketsState extends Equatable {
  const MarketsState();

  @override
  List<Object?> get props => [];
}

class MarketsInitial extends MarketsState {}

class MarketsLoading extends MarketsState {}

class MarketsLoaded extends MarketsState {
  final List<Stock> stocks;
  final List<Stock> filteredStocks;
  final String searchQuery;
  final Sector activeFilter;
  final SortBy activeSort;

  const MarketsLoaded({
    required this.stocks,
    required this.filteredStocks,
    required this.searchQuery,
    required this.activeFilter,
    required this.activeSort,
  });

  @override
  List<Object?> get props => [
    stocks,
    filteredStocks,
    searchQuery,
    activeFilter,
    activeSort,
  ];

  MarketsLoaded copyWith({
    List<Stock>? stocks,
    List<Stock>? filteredStocks,
    String? searchQuery,
    Sector? activeFilter,
    SortBy? activeSort,
  }) {
    return MarketsLoaded(
      stocks: stocks ?? this.stocks,
      filteredStocks: filteredStocks ?? this.filteredStocks,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
      activeSort: activeSort ?? this.activeSort,
    );
  }
}

class MarketsError extends MarketsState {
  final String message;
  const MarketsError(this.message);

  @override
  List<Object?> get props => [message];
}
