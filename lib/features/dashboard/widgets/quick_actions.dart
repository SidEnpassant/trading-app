import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {
        'icon': Icons.add_circle,
        'label': 'Buy',
        'color': AppTheme.positiveColor,
      },
      {
        'icon': Icons.remove_circle,
        'label': 'Sell',
        'color': AppTheme.negativeColor,
      },
      {
        'icon': Icons.list_alt,
        'label': 'Orders',
        'color': AppTheme.accentColor,
      },
      {'icon': Icons.star, 'label': 'Watchlist', 'color': Colors.orange},
      {
        'icon': Icons.account_balance_wallet,
        'label': 'Portfolio',
        'color': Colors.blue,
      },
      {'icon': Icons.person, 'label': 'Profile', 'color': Colors.purple},
    ];

    return CustomCard(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return InkWell(
            onTap: () {
              // Handle navigation based on label
              // TODO: Implement navigation
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action['icon'] as IconData,
                  color: action['color'] as Color,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  action['label'] as String,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
