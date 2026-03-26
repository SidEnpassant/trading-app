import 'package:equatable/equatable.dart';
import 'package:trading/features/stock_details/data/models/buy_sell_request.dart';

abstract class StockDetailsEvent extends Equatable {
  const StockDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDetail extends StockDetailsEvent {
  final String symbol;

  const LoadDetail(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class RefreshPrice extends StockDetailsEvent {
  final String symbol;

  const RefreshPrice(this.symbol);

  @override
  List<Object?> get props => [symbol];
}

class PlaceOrder extends StockDetailsEvent {
  final BuySellRequest request;

  const PlaceOrder(this.request);

  @override
  List<Object?> get props => [request];
}
