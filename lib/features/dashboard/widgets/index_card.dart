import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class IndexCard extends StatelessWidget {
  final dynamic index; // MarketIndex

  const IndexCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final color = index.isPositive
        ? AppTheme.positiveColor
        : AppTheme.negativeColor;
    return CustomCard(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            index.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.rupees(index.value),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                index.isPositive ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: color,
              ),
              const SizedBox(width: 4),
              Text(
                PercentageFormatter.format(index.changePercent),
                style: TextStyle(color: color, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
