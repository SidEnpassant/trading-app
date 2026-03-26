import 'dart:math';
import 'package:trading/features/stock_details/data/models/historical_data.dart';
import 'package:trading/features/stock_details/data/models/order_book.dart';

class ChartDataSource {
  final Random _random = Random();

  List<HistoricalDataPoint> generateHistoricalData({
    required double currentPrice,
    required String timeframe,
  }) {
    final now = DateTime.now();
    final points = _getPointCount(timeframe);
    final interval = _getInterval(timeframe);
    final List<HistoricalDataPoint> data = [];

    double price = currentPrice * 0.8; // Start lower for upward trend bias
    final volatility = currentPrice * 0.02; // 2% volatility

    for (int i = points - 1; i >= 0; i--) {
      final date = now.subtract(Duration(minutes: i * interval));

      // Random walk
      price = price * (1 + (_random.nextDouble() - 0.48) * 0.02);
      final open = price;
      final close =
          price * (1 + (_random.nextDouble() - 0.5) * volatility / price);
      final high = max(open, close) * (1 + _random.nextDouble() * 0.01);
      final low = min(open, close) * (1 - _random.nextDouble() * 0.01);
      final volume = _random.nextInt(1000000) + 100000;

      data.add(
        HistoricalDataPoint(
          date: date,
          open: open,
          high: high,
          low: low,
          close: close,
          volume: volume,
        ),
      );

      price = close;
    }

    return data;
  }

  OrderBook generateOrderBook(double currentPrice) {
    final bids = <BidAsk>[];
    final asks = <BidAsk>[];
    final bidSpacing = currentPrice * 0.002; // 0.2% spacing
    final askSpacing = currentPrice * 0.002;

    // 5 bids below current price
    for (int i = 1; i <= 5; i++) {
      final price = currentPrice - (bidSpacing * i);
      final quantity = _random.nextInt(5000) + 1000;
      bids.add(BidAsk(price: price, quantity: quantity));
    }

    // 5 asks above current price
    for (int i = 1; i <= 5; i++) {
      final price = currentPrice + (askSpacing * i);
      final quantity = _random.nextInt(5000) + 1000;
      asks.add(BidAsk(price: price, quantity: quantity));
    }

    // Sort bids descending, asks ascending
    bids.sort((a, b) => b.price.compareTo(a.price));
    asks.sort((a, b) => a.price.compareTo(b.price));

    return OrderBook(bids: bids, asks: asks);
  }

  int _getPointCount(String timeframe) {
    switch (timeframe) {
      case '1D':
        return 390; // Trading minutes in a day
      case '1W':
        return 7;
      case '1M':
        return 30;
      case '3M':
        return 90;
      case '1Y':
        return 252; // Trading days
      case 'ALL':
        return 1000;
      default:
        return 30;
    }
  }

  int _getInterval(String timeframe) {
    // Return minutes interval between data points
    switch (timeframe) {
      case '1D':
        return 1; // 1 minute
      case '1W':
        return 60 * 24; // 1 day in minutes
      case '1M':
        return 60 * 24; // 1 day
      case '3M':
        return 60 * 24; // 1 day
      case '1Y':
        return 60 * 24; // 1 day
      case 'ALL':
        return 60 * 24 * 7; // 1 week
      default:
        return 60 * 24;
    }
  }
}
