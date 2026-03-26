import 'package:flutter/material.dart';
import 'package:trading/core/theme/app_theme.dart';

class CancelOrderDialog extends StatelessWidget {
  final String orderId;
  final VoidCallback onConfirm;

  const CancelOrderDialog({
    super.key,
    required this.orderId,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: theme.cardColor,
      title: Text(
        'Cancel Order',
        style: theme.textTheme.titleLarge,
      ),
      content: Text(
        'Are you sure you want to cancel order #$orderId? This action cannot be undone.',
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Keep Order',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Cancel Order'),
        ),
      ],
    );
  }
}

