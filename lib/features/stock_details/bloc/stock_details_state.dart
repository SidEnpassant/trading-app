import 'package:equatable/equatable.dart';
import 'package:trading/features/stock_details/data/models/stock_detail.dart';
import 'package:trading/features/stock_details/data/models/historical_data.dart';
import 'package:trading/features/stock_details/data/models/order_book.dart';

abstract class StockDetailsState extends Equatable {
  const StockDetailsState();

  @override
  List<Object?> get props => [];
}

class StockDetailsInitial extends StockDetailsState {}

class StockDetailsLoading extends StockDetailsState {}

class StockDetailsLoaded extends StockDetailsState {
  final StockDetail stockDetail;
  final List<HistoricalDataPoint> historicalData;
  final OrderBook orderBook;
  final String? selectedTimeframe;

  const StockDetailsLoaded({
    required this.stockDetail,
    required this.historicalData,
    required this.orderBook,
    this.selectedTimeframe,
  });

  @override
  List<Object?> get props => [
    stockDetail,
    historicalData,
    orderBook,
    selectedTimeframe,
  ];
}

class OrderPlaced extends StockDetailsState {
  final String orderId;

  const OrderPlaced(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class StockDetailsError extends StockDetailsState {
  final String message;

  const StockDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
