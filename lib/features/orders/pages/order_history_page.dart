import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/orders/bloc/orders_bloc.dart';
import 'package:trading/features/orders/bloc/orders_event.dart';
import 'package:trading/features/orders/bloc/orders_state.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';
import 'package:trading/features/orders/widgets/order_filter_chips.dart';
import 'package:trading/features/orders/widgets/order_tile.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  OrderHistoryFilter _selectedFilter = OrderHistoryFilter.all;

  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(LoadOrders());
  }

  void _onFilterSelected(OrderHistoryFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
    context.read<OrdersBloc>().add(FilterByStatus(filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
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
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
            final sections = _groupOrdersByDate(orders);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OrderFilterChips(
                    filters: OrderHistoryFilter.values,
                    selectedFilter: _selectedFilter,
                    onFilterSelected: _onFilterSelected,
                  ),
                ),
                Expanded(child: _buildOrderList(context, sections)),
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

  Widget _buildOrderList(
    BuildContext context,
    Map<String, List<Order>> grouped,
  ) {
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
              onCancel: null, // History is read-only
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
