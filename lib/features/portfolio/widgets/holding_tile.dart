import 'package:flutter/material.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/portfolio/data/models/holding.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class HoldingTile extends StatelessWidget {
  final Holding holding;
  final VoidCallback? onTap;

  const HoldingTile({super.key, required this.holding, this.onTap});

  @override
  Widget build(BuildContext context) {
    final symbol = holding.stock.symbol;
    final name = holding.stock.name;
    final quantity = holding.quantity;
    final avgPrice = holding.avgPrice;
    final currentPrice = holding.currentPrice;
    final totalPnl = holding.totalPnl;
    final currentValue = quantity * currentPrice;

    final isPositive = totalPnl >= 0;
    final pnlColor = isPositive ? Colors.green : Colors.red;
    final pnlSign = isPositive ? '+' : '';

    return CustomCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              symbol.isNotEmpty ? symbol[0] : '?',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'Qty: $quantity @ ${CurrencyFormatter.rupees(avgPrice)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.rupees(currentValue),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: pnlColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$pnlSign${CurrencyFormatter.rupees(totalPnl)}',
                  style: TextStyle(color: pnlColor, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
