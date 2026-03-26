import 'package:flutter/material.dart';
import 'package:trading/core/utils/formatting.dart';

class PnlCard extends StatelessWidget {
  final String label;
  final double value;
  final bool showSign;

  const PnlCard({
    super.key,
    required this.label,
    required this.value,
    this.showSign = true,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = value >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    final sign = showSign && isPositive ? '+' : '';
    final formatted = CurrencyFormatter.rupees(value);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(
          '$sign$formatted',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
