import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/models/order_type.dart';

class OrderDetailBottomSheet extends StatelessWidget {
  final Order order;

  const OrderDetailBottomSheet({super.key, required this.order});

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.open:
        return const Color(0xFFFFC107);
      case OrderStatus.completed:
        return const Color(0xFF00C853);
      case OrderStatus.cancelled:
        return const Color(0xFFFF5252);
      case OrderStatus.rejected:
        return const Color(0xFFFF5252);
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.open:
        return 'Open';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.rejected:
        return 'Rejected';
    }
  }

  String _getOrderTypeText() {
    switch (order.orderType) {
      case OrderType.market:
        return 'Market';
      case OrderType.limit:
        return 'Limit';
      case OrderType.stopLoss:
        return 'Stop Loss';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);
    final orderTypeText = _getOrderTypeText();

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).textTheme.bodySmall?.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.stock.symbol,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.stock.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor, width: 1),
                ),
                child: Text(
                  statusText,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          _buildDetailRow('Order Type', orderTypeText),
          _buildDetailRow('Quantity', '${order.quantity} shares'),
          _buildDetailRow('Price', CurrencyFormatter.rupees(order.price)),
          _buildDetailRow(
            'Total Value',
            CurrencyFormatter.rupees(order.price * order.quantity),
          ),
          _buildDetailRow('Status', statusText),
          _buildDetailRow(
            'Placed At',
            DateTimeFormatter.formatFull(order.timestamp),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
