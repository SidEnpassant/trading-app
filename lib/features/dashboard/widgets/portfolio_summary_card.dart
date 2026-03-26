import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final dynamic summary; // PortfolioSummary

  const PortfolioSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final dayColor = summary.dayPnl >= 0
        ? AppTheme.positiveColor
        : AppTheme.negativeColor;
    final overallColor = summary.overallPnl >= 0
        ? AppTheme.positiveColor
        : AppTheme.negativeColor;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Portfolio Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItem(
                'Total Value',
                CurrencyFormatter.rupees(summary.totalValue),
              ),
              _buildItem(
                'Day P&L',
                PercentageFormatter.format(
                  summary.dayPnl / summary.totalValue * 100,
                ),
                color: dayColor,
              ),
              _buildItem(
                'Overall P&L',
                PercentageFormatter.format(
                  summary.overallPnl / summary.totalValue * 100,
                ),
                color: overallColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
