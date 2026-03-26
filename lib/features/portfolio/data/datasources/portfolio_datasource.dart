import 'package:trading/features/orders/data/models/stock_brief.dart';
import 'package:trading/features/portfolio/data/models/holding.dart';

abstract class PortfolioDataSource {
  Future<Map<String, StockBrief>> getAllMarketData();
  Stream<Map<String, StockBrief>> getMarketDataStream();
  void updatePrice(String symbol, double newPrice, double prevClose);
}
