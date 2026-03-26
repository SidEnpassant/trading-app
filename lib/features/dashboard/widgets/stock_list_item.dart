import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class StockListItem extends StatelessWidget {
  final dynamic stock; // StockBrief

  const StockListItem({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final color = stock.isPositive ?? stock.change >= 0
        ? AppTheme.positiveColor
        : AppTheme.negativeColor;
    return CustomCard(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.accentColor,
          child: Text(
            stock.symbol[0],
            style: const TextStyle(color: AppTheme.textPrimary),
          ),
        ),
        title: Text(
          stock.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(stock.symbol),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CurrencyFormatter.rupees(stock.currentPrice),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              PercentageFormatter.format(
                stock.changePercent ?? stock.change / stock.currentPrice * 100,
              ),
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
