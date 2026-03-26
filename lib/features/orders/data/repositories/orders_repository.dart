import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';

abstract class OrdersRepository {
  Future<List<Order>> getAllOrders();
  Future<List<Order>> getOrdersByFilter(OrderHistoryFilter filter);
  Future<void> cancelOrder(String orderId);
  Future<Order> addOrder(Order order);
}
