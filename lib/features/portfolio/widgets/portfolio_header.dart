import 'package:flutter/material.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/portfolio/data/models/portfolio_pnl.dart';
import 'pnl_card.dart';

class PortfolioHeader extends StatelessWidget {
  final PortfolioPnl summary;

  const PortfolioHeader({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final totalValue = summary.currentValue;
    final dayPnl = summary.dayPnl;
    final dayPnlPercent = summary.dayPnlPercent;
    final isPositive = dayPnl >= 0;
    final arrow = isPositive ? Icons.arrow_upward : Icons.arrow_downward;
    final color = isPositive ? Colors.green : Colors.red;

    return Column(
      children: [
        Text(
          CurrencyFormatter.rupees(totalValue),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(arrow, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              '${isPositive ? '+' : ''}${CurrencyFormatter.rupees(dayPnl)} (${dayPnlPercent.toStringAsFixed(2)}%)',
              style: TextStyle(color: color, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
