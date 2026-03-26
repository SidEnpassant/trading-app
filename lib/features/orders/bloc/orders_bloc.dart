import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/di/service_locator.dart';
import 'package:trading/features/orders/bloc/orders_event.dart';
import 'package:trading/features/orders/bloc/orders_state.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/repositories/orders_repository.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepository _ordersRepository = sl<OrdersRepository>();
  List<Order> _allOrders = [];
  OrderHistoryFilter _currentFilter = OrderHistoryFilter.all;

  OrdersBloc() : super(OrdersLoading()) {
    on<LoadOrders>(_onLoadOrders);
    on<CancelOrder>(_onCancelOrder);
    on<FilterByStatus>(_onFilterByStatus);
    add(LoadOrders());
  }

  Future<void> _onLoadOrders(
    LoadOrders event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrdersLoading());
    try {
      _allOrders = await _ordersRepository.getAllOrders();
      emit(_buildLoadedState());
    } catch (e) {
      emit(OrdersError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onCancelOrder(
    CancelOrder event,
    Emitter<OrdersState> emit,
  ) async {
    try {
      await _ordersRepository.cancelOrder(event.orderId);
      _allOrders = await _ordersRepository.getAllOrders();
      emit(_buildLoadedState());
    } catch (e) {
      emit(OrdersError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  void _onFilterByStatus(FilterByStatus event, Emitter<OrdersState> emit) {
    _currentFilter = event.filter;
    emit(_buildLoadedState());
  }

  OrdersLoaded _buildLoadedState() {
    List<Order> filteredOrders;
    switch (_currentFilter) {
      case OrderHistoryFilter.all:
        filteredOrders = List<Order>.unmodifiable(_allOrders);
        break;
      case OrderHistoryFilter.open:
        filteredOrders = _allOrders
            .where((o) => o.status == OrderStatus.open)
            .toList();
        break;
      case OrderHistoryFilter.completed:
        filteredOrders = _allOrders
            .where((o) => o.status == OrderStatus.completed)
            .toList();
        break;
      case OrderHistoryFilter.cancelled:
        filteredOrders = _allOrders
            .where((o) => o.status == OrderStatus.cancelled)
            .toList();
        break;
    }
    return OrdersLoaded(orders: filteredOrders, activeFilter: _currentFilter);
  }
}
