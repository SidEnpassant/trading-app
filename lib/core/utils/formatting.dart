import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _rupeeFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static String rupees(double amount) {
    return _rupeeFormat.format(amount);
  }

  static String formatCompact(double amount) {
    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(2)} Cr';
    } else if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(2)} L';
    } else if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)} K';
    }
    return rupees(amount);
  }
}

class PercentageFormatter {
  static String format(double percentage, {int decimals = 2}) {
    final sign = percentage >= 0 ? '+' : '';
    return '$sign${percentage.toStringAsFixed(decimals)}%';
  }
}

class DateTimeFormatter {
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateFormat = DateFormat('dd MMM yyyy');
  static final DateFormat _fullFormat = DateFormat('dd MMM yyyy, HH:mm');

  static String formatTime(DateTime dt) => _timeFormat.format(dt);
  static String formatDate(DateTime dt) => _dateFormat.format(dt);
  static String formatFull(DateTime dt) => _fullFormat.format(dt);
  static String formatRelative(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDate(dt);
  }
}

class NumberFormatter {
  static final NumberFormat _compactFormat = NumberFormat.compact();

  static String formatVolume(int volume) {
    return _compactFormat.format(volume);
  }
}
