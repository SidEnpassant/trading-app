import 'package:equatable/equatable.dart';
import 'package:trading/features/markets/data/models/stock.dart';
import 'package:trading/features/markets/data/models/stock_filter.dart';

abstract class MarketsEvent extends Equatable {
  const MarketsEvent();

  @override
  List<Object?> get props => [];
}

class LoadStocks extends MarketsEvent {}

class SearchStocks extends MarketsEvent {
  final String query;
  const SearchStocks(this.query);

  @override
  List<Object?> get props => [query];
}

class ApplyFilter extends MarketsEvent {
  final Sector filter;
  const ApplyFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class ChangeSort extends MarketsEvent {
  final SortBy sortBy;
  const ChangeSort(this.sortBy);

  @override
  List<Object?> get props => [sortBy];
}
