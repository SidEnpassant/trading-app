import 'package:trading/features/orders/data/models/stock_brief.dart';

abstract class WatchlistDataSource {
  Future<List<String>> getWatchlistSymbols();
  Future<void> addSymbol(String symbol);
  Future<void> removeSymbol(String symbol);
}
