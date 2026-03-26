import 'dart:math';
import 'package:trading/core/utils/constants.dart';
import 'package:trading/features/markets/data/models/stock.dart';
import 'package:trading/features/stock_details/data/datasources/chart_datasource.dart';
import 'package:trading/features/stock_details/data/models/buy_sell_request.dart';
import 'package:trading/features/stock_details/data/models/historical_data.dart';
import 'package:trading/features/stock_details/data/models/order_book.dart';
import 'package:trading/features/stock_details/data/models/stock_detail.dart';
import 'package:trading/features/stock_details/data/repositories/stock_details_repository.dart';

class StockDetailsRepositoryImpl implements StockDetailsRepository {
  final ChartDataSource _chartDataSource;
  final Random _random = Random();

  StockDetailsRepositoryImpl({required ChartDataSource chartDataSource})
    : _chartDataSource = chartDataSource;

  @override
  Future<StockDetail> getStockDetail(String symbol) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // Generate mock stock data
    final basePrice = _getBasePrice(symbol);
    final change = (_random.nextDouble() - 0.5) * 20;
    final changePercent = (change / basePrice) * 100;
    final isPositive = change >= 0;

    return StockDetail(
      symbol: symbol,
      name: _getCompanyName(symbol),
      price: basePrice + change,
      change: change,
      changePercent: changePercent,
      isPositive: isPositive,
      sector: _getSector(symbol),
      marketCap: basePrice * _getSharesOutstanding(symbol),
      pe: _getPE(symbol),
      pb: _getPB(symbol),
      dividendYield: _getDividendYield(symbol),
      dayHigh: basePrice + _random.nextDouble() * 10,
      dayLow: basePrice - _random.nextDouble() * 10,
      open: basePrice + (_random.nextDouble() - 0.5) * 5,
      prevClose: basePrice - (_random.nextDouble() - 0.5) * 5,
      volume: _random.nextInt(5000000) + 1000000,
    );
  }

  @override
  Future<List<HistoricalDataPoint>> getHistoricalData(
    String symbol,
    String timeframe,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final stockDetail = await getStockDetail(symbol);
    return _chartDataSource.generateHistoricalData(
      currentPrice: stockDetail.price,
      timeframe: timeframe,
    );
  }

  @override
  Future<OrderBook> getOrderBook(String symbol) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final stockDetail = await getStockDetail(symbol);
    return _chartDataSource.generateOrderBook(stockDetail.price);
  }

  @override
  Future<String> placeOrder(BuySellRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Generate mock order ID
    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    return orderId;
  }

  // Mock data helpers
  double _getBasePrice(String symbol) {
    final seed = symbol.codeUnits.fold<int>(0, (a, b) => a + b);
    return 100.0 + (seed % 5000) / 10.0;
  }

  String _getCompanyName(String symbol) {
    final names = {
      'RELIANCE': 'Reliance Industries Ltd.',
      'TCS': 'Tata Consultancy Services Ltd.',
      'INFY': 'Infosys Ltd.',
      'HDFCBANK': 'HDFC Bank Ltd.',
      'ICICIBANK': 'ICICI Bank Ltd.',
      'SBIN': 'State Bank of India',
      'BHARTIARTL': 'Bharti Airtel Ltd.',
      'WIPRO': 'Wipro Ltd.',
      'AXISBANK': 'Axis Bank Ltd.',
      'KOTAKBANK': 'Kotak Mahindra Bank Ltd.',
      'ITC': 'ITC Ltd.',
      'SUNPHARMA': 'Sun Pharmaceutical Industries Ltd.',
      'BAJAJFINSV': 'Bajaj Finance Ltd.',
      'HINDUNILVR': 'Hindustan Unilever Ltd.',
      'MARUTI': 'Maruti Suzuki India Ltd.',
      'ASIANPAINT': 'Asian Paints Ltd.',
      'TITAN': 'Titan Company Ltd.',
      'ULTRACEMCO': 'UltraTech Cement Ltd.',
      'TATAMOTORS': 'Tata Motors Ltd.',
      'BAJAJ-AUTO': 'Bajaj Auto Ltd.',
      'NESTLEIND': 'Nestle India Ltd.',
      'POWERGRID': 'Power Grid Corporation of India Ltd.',
      'NTPC': 'NTPC Ltd.',
      'ADANIENT': 'Adani Enterprises Ltd.',
      'ADANIPORTS': 'Adani Ports and Special Economic Zone Ltd.',
      'ADANIGREEN': 'Adani Green Energy Ltd.',
      'DMART': 'Avenue Supermarts Ltd.',
      'ZOMATO': 'Zomato Ltd.',
    };
    return names[symbol] ?? '$symbol Industries Ltd.';
  }

  String _getSector(String symbol) {
    final sectors = {
      'RELIANCE': 'Oil & Gas',
      'TCS': 'IT',
      'INFY': 'IT',
      'HDFCBANK': 'Banking',
      'ICICIBANK': 'Banking',
      'SBIN': 'Banking',
      'BHARTIARTL': 'Telecom',
      'WIPRO': 'IT',
      'AXISBANK': 'Banking',
      'KOTAKBANK': 'Banking',
      'ITC': 'FMCG',
      'SUNPHARMA': 'Pharma',
      'BAJAJFINSV': 'Finance',
      'HINDUNILVR': 'FMCG',
      'MARUTI': 'Auto',
      'ASIANPAINT': 'Construction',
      'TITAN': 'Construction',
      'ULTRACEMCO': 'Construction',
      'TATAMOTORS': 'Auto',
      'BAJAJ-AUTO': 'Auto',
      'NESTLEIND': 'FMCG',
      'POWERGRID': 'Power',
      'NTPC': 'Power',
      'ADANIENT': 'Metals',
      'ADANIPORTS': 'Construction',
      'ADANIGREEN': 'Power',
      'DMART': 'Retail',
      'ZOMATO': 'Food Delivery',
    };
    return sectors[symbol] ?? 'Other';
  }

  int _getSharesOutstanding(String symbol) {
    final seed = symbol.codeUnits.fold<int>(0, (a, b) => a + b);
    return 100000000 + (seed % 900000000);
  }

  double _getPE(String symbol) {
    final seed = symbol.codeUnits.fold<int>(0, (a, b) => a + b);
    return 10.0 + (seed % 400) / 10.0;
  }

  double _getPB(String symbol) {
    final seed = symbol.codeUnits.fold<int>(0, (a, b) => a + b);
    return 1.0 + (seed % 100) / 10.0;
  }

  double _getDividendYield(String symbol) {
    final seed = symbol.codeUnits.fold<int>(0, (a, b) => a + b);
    return (seed % 50) / 10.0;
  }
}
