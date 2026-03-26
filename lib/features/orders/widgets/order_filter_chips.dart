import 'package:flutter/material.dart';
import 'package:trading/features/orders/data/models/order_history_filter.dart';

class OrderFilterChips extends StatelessWidget {
  final List<OrderHistoryFilter> filters;
  final OrderHistoryFilter selectedFilter;
  final ValueChanged<OrderHistoryFilter> onFilterSelected;

  const OrderFilterChips({
    super.key,
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter == selectedFilter;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(
                filter.name[0].toUpperCase() + filter.name.substring(1),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : theme.textTheme.bodyMedium?.color,
                ),
              ),
              selected: isSelected,
              onSelected: (_) => onFilterSelected(filter),
              selectedColor: theme.primaryColor,
              backgroundColor: theme.cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? theme.primaryColor : theme.dividerColor,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          );
        },
      ),
    );
  }
}
