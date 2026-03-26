import 'dart:async';
import 'package:trading/features/orders/data/models/stock_brief.dart';
import 'package:trading/features/portfolio/data/datasources/portfolio_datasource.dart';

class PortfolioDataSourceImpl implements PortfolioDataSource {
  final Map<String, StockBrief> _marketData = {};
  final StreamController<Map<String, StockBrief>> _controller =
      StreamController.broadcast();

  PortfolioDataSourceImpl() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _marketData['RELIANCE'] = StockBrief(
      symbol: 'RELIANCE',
      name: 'Reliance Industries',
      currentPrice: 2500.0,
      prevClose: 2480.0,
    );
    _marketData['TCS'] = StockBrief(
      symbol: 'TCS',
      name: 'Tata Consultancy',
      currentPrice: 3500.0,
      prevClose: 3480.0,
    );
    _marketData['HDFCBANK'] = StockBrief(
      symbol: 'HDFCBANK',
      name: 'HDFC Bank',
      currentPrice: 1800.0,
      prevClose: 1790.0,
    );
    _marketData['INFY'] = StockBrief(
      symbol: 'INFY',
      name: 'Infosys',
      currentPrice: 1200.0,
      prevClose: 1190.0,
    );
    _marketData['ICICIBANK'] = StockBrief(
      symbol: 'ICICIBANK',
      name: 'ICICI Bank',
      currentPrice: 950.0,
      prevClose: 940.0,
    );
  }

  @override
  Future<Map<String, StockBrief>> getAllMarketData() async {
    return Map.from(_marketData);
  }

  @override
  Stream<Map<String, StockBrief>> getMarketDataStream() {
    return _controller.stream;
  }

  @override
  void updatePrice(String symbol, double newPrice, double prevClose) {
    if (_marketData.containsKey(symbol)) {
      _marketData[symbol] = StockBrief(
        symbol: symbol,
        name: _marketData[symbol]!.name,
        currentPrice: newPrice,
        prevClose: prevClose,
      );
      _controller.add(Map.from(_marketData));
    }
  }
}
