import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/orders/bloc/orders_bloc.dart';
import 'package:trading/features/orders/bloc/orders_event.dart';
import 'package:trading/features/orders/bloc/orders_state.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/widgets/cancel_order_dialog.dart';
import 'package:trading/features/orders/widgets/order_filter_chips.dart';
import 'package:trading/features/orders/widgets/order_tile.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  OrderHistoryFilter _historyFilter = OrderHistoryFilter.completed;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<OrdersBloc>().add(LoadOrders());
  }

  void _onTabChanged() {
    if (_tabController.index == 0) {
      context.read<OrdersBloc>().add(FilterByStatus(OrderHistoryFilter.open));
    } else {
      context.read<OrdersBloc>().add(FilterByStatus(_historyFilter));
    }
  }

  void _onHistoryFilterSelected(OrderHistoryFilter filter) {
    setState(() {
      _historyFilter = filter;
    });
    context.read<OrdersBloc>().add(FilterByStatus(filter));
  }

  void _showCancelDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (context) => CancelOrderDialog(
        orderId: orderId,
        onConfirm: () {
          context.read<OrdersBloc>().add(CancelOrder(orderId));
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrdersLoaded) {
            final isHistoryTab = _tabController.index == 1;
            return Column(
              children: [
                if (isHistoryTab)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: OrderFilterChips(
                      filters: const [
                        OrderHistoryFilter.completed,
                        OrderHistoryFilter.cancelled,
                      ],
                      selectedFilter: _historyFilter,
                      onFilterSelected: _onHistoryFilterSelected,
                    ),
                  ),
                Expanded(child: _buildOrderList(context, state.orders)),
              ],
            );
          } else if (state is OrdersError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, List<Order> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text('No orders found.', style: TextStyle(color: Colors.grey)),
      );
    }

    // Group orders by date
    final grouped = _groupOrdersByDate(orders);
    final dateOrder = ['Today', 'Yesterday', 'Older'];

    return ListView(
      children: dateOrder.where((label) => grouped.containsKey(label)).expand((
        label,
      ) {
        final sectionOrders = grouped[label]!;
        return [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          ...sectionOrders.map((order) {
            return OrderTile(
              order: order,
              onCancel: order.status == OrderStatus.open
                  ? () => _showCancelDialog(context, order.id)
                  : null,
            );
          }),
        ];
      }).toList(),
    );
  }

  Map<String, List<Order>> _groupOrdersByDate(List<Order> orders) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<Order>> groups = {
      'Today': [],
      'Yesterday': [],
      'Older': [],
    };

    for (final order in orders) {
      final orderDate = DateTime(
        order.timestamp.year,
        order.timestamp.month,
        order.timestamp.day,
      );
      if (orderDate == today) {
        groups['Today']!.add(order);
      } else if (orderDate == yesterday) {
        groups['Yesterday']!.add(order);
      } else {
        groups['Older']!.add(order);
      }
    }

    groups.removeWhere((key, value) => value.isEmpty);
    return groups;
  }
}
