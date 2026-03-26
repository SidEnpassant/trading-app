import 'package:trading/features/orders/data/models/stock_brief.dart';

abstract class WatchlistRepository {
  Future<List<StockBrief>> getWatchlist();
  Future<void> addToWatchlist(StockBrief stock);
  Future<void> removeFromWatchlist(String symbol);
}
