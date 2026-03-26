import 'package:equatable/equatable.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrders extends OrdersEvent {}

class CancelOrder extends OrdersEvent {
  final String orderId;
  const CancelOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class FilterByStatus extends OrdersEvent {
  final OrderHistoryFilter filter;
  const FilterByStatus(this.filter);

  @override
  List<Object?> get props => [filter];
}
