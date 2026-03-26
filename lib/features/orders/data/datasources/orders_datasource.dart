import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_type.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/models/stock_brief.dart';

abstract class OrdersDataSource {
  Future<List<Order>> getAllOrders();
  Future<List<Order>> getOrdersByFilter(OrderStatus? status);
  Future<void> cancelOrder(String orderId);
  Future<Order> addOrder(Order order);
}

class OrdersDataSourceImpl implements OrdersDataSource {
  final List<Order> _orders = [];

  OrdersDataSourceImpl() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    final now = DateTime.now();
    final stocks = [
      StockBrief(
        symbol: 'RELIANCE',
        name: 'Reliance Industries',
        currentPrice: 2500.0,
      ),
      StockBrief(symbol: 'TCS', name: 'Tata Consultancy', currentPrice: 3500.0),
      StockBrief(symbol: 'HDFCBANK', name: 'HDFC Bank', currentPrice: 1800.0),
      StockBrief(symbol: 'INFY', name: 'Infosys', currentPrice: 1200.0),
      StockBrief(symbol: 'ICICIBANK', name: 'ICICI Bank', currentPrice: 950.0),
    ];

    // Add dummy orders with different statuses
    _orders.addAll([
      Order(
        id: 'ORD001',
        stock: stocks[0],
        orderType: OrderType.market,
        quantity: 10,
        price: 2500.0,
        status: OrderStatus.open,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      Order(
        id: 'ORD002',
        stock: stocks[1],
        orderType: OrderType.limit,
        quantity: 5,
        price: 3450.0,
        status: OrderStatus.completed,
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      Order(
        id: 'ORD003',
        stock: stocks[2],
        orderType: OrderType.stopLoss,
        quantity: 20,
        price: 1750.0,
        status: OrderStatus.cancelled,
        timestamp: now.subtract(const Duration(days: 1)),
      ),
      Order(
        id: 'ORD004',
        stock: stocks[3],
        orderType: OrderType.market,
        quantity: 15,
        price: 1200.0,
        status: OrderStatus.open,
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
      Order(
        id: 'ORD005',
        stock: stocks[4],
        orderType: OrderType.limit,
        quantity: 8,
        price: 940.0,
        status: OrderStatus.rejected,
        timestamp: now.subtract(const Duration(days: 2)),
      ),
    ]);
  }

  @override
  Future<List<Order>> getAllOrders() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_orders);
  }

  @override
  Future<List<Order>> getOrdersByFilter(OrderStatus? status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (status == null) return List.unmodifiable(_orders);
    return List.unmodifiable(_orders.where((o) => o.status == status).toList());
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index] = Order(
        id: _orders[index].id,
        stock: _orders[index].stock,
        orderType: _orders[index].orderType,
        quantity: _orders[index].quantity,
        price: _orders[index].price,
        status: OrderStatus.cancelled,
        timestamp: _orders[index].timestamp,
      );
    }
  }

  @override
  Future<Order> addOrder(Order order) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _orders.insert(0, order);

    // Simulate execution for market orders after 5 seconds
    if (order.orderType == OrderType.market &&
        order.status == OrderStatus.open) {
      Future.delayed(const Duration(seconds: 5), () {
        final index = _orders.indexWhere((o) => o.id == order.id);
        if (index != -1) {
          _orders[index] = Order(
            id: _orders[index].id,
            stock: _orders[index].stock,
            orderType: _orders[index].orderType,
            quantity: _orders[index].quantity,
            price: _orders[index].price,
            status: OrderStatus.completed,
            timestamp: _orders[index].timestamp,
          );
        }
      });
    }

    return order;
  }
}
