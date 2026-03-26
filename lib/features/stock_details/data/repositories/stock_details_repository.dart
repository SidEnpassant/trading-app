import 'package:trading/features/stock_details/data/models/buy_sell_request.dart';
import 'package:trading/features/stock_details/data/models/historical_data.dart';
import 'package:trading/features/stock_details/data/models/order_book.dart';
import 'package:trading/features/stock_details/data/models/stock_detail.dart';

abstract class StockDetailsRepository {
  Future<StockDetail> getStockDetail(String symbol);
  Future<List<HistoricalDataPoint>> getHistoricalData(
    String symbol,
    String timeframe,
  );
  Future<OrderBook> getOrderBook(String symbol);
  Future<String> placeOrder(BuySellRequest request);
}
