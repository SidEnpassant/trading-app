import 'package:trading/core/utils/logger.dart';
import 'package:trading/features/orders/data/datasources/orders_datasource.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersDataSource ordersDataSource;

  OrdersRepositoryImpl({required this.ordersDataSource});

  @override
  Future<List<Order>> getAllOrders() async {
    try {
      Logger.debug('Fetching all orders');
      return await ordersDataSource.getAllOrders();
    } catch (e) {
      Logger.error('Failed to fetch orders', e);
      rethrow;
    }
  }

  @override
  Future<List<Order>> getOrdersByFilter(OrderHistoryFilter filter) async {
    try {
      Logger.debug('Fetching orders with filter: $filter');
      switch (filter) {
        case OrderHistoryFilter.all:
          return await ordersDataSource.getAllOrders();
        case OrderHistoryFilter.open:
          return await ordersDataSource.getOrdersByFilter(OrderStatus.open);
        case OrderHistoryFilter.completed:
          return await ordersDataSource.getOrdersByFilter(
            OrderStatus.completed,
          );
        case OrderHistoryFilter.cancelled:
          return await ordersDataSource.getOrdersByFilter(
            OrderStatus.cancelled,
          );
      }
    } catch (e) {
      Logger.error('Failed to fetch filtered orders', e);
      rethrow;
    }
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    try {
      Logger.debug('Cancelling order: $orderId');
      await ordersDataSource.cancelOrder(orderId);
    } catch (e) {
      Logger.error('Failed to cancel order $orderId', e);
      rethrow;
    }
  }

  @override
  Future<Order> addOrder(Order order) async {
    try {
      Logger.debug('Adding order: ${order.id}');
      return await ordersDataSource.addOrder(order);
    } catch (e) {
      Logger.error('Failed to add order', e);
      rethrow;
    }
  }
}
