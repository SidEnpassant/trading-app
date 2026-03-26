import 'package:flutter/material.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/models/order_type.dart';
import 'package:trading/features/orders/widgets/order_detail_bottom_sheet.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final VoidCallback? onCancel;

  const OrderTile({super.key, required this.order, this.onCancel});

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

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderDetailBottomSheet(order: order),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);
    final orderTypeText = _getOrderTypeText();

    return CustomCard(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          InkWell(
            onTap: () => _showOrderDetails(context),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.stock.symbol,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.stock.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${order.quantity} shares',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.rupees(order.price),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: Text(
                      statusText,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.all(16),
            title: const SizedBox.shrink(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Type', style: theme.textTheme.bodyMedium),
                  Text(
                    orderTypeText,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Value', style: theme.textTheme.bodyMedium),
                  Text(
                    CurrencyFormatter.rupees(order.price * order.quantity),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Placed At', style: theme.textTheme.bodyMedium),
                  Text(
                    DateTimeFormatter.formatFull(order.timestamp),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              if (order.status == OrderStatus.open && onCancel != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel Order'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
