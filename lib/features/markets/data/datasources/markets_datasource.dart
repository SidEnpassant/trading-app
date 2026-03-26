import 'package:trading/features/markets/data/models/stock.dart';

abstract class MarketsDataSource {
  Future<List<Stock>> getStocks();
}

class MarketsDataSourceImpl implements MarketsDataSource {
  final List<Stock> _stocks = [];

  MarketsDataSourceImpl() {
    _generateStocks();
  }

  void _generateStocks() {
    final random = DateTime.now().millisecondsSinceEpoch;
    final stockData = [
      {
        'symbol': 'RELIANCE',
        'name': 'Reliance Industries Ltd.',
        'sector': 'Oil & Gas',
        'marketCap': 15000000000,
        'pe': 35.0,
        'pb': 3.5,
        'dividend': 0.5,
      },
      {
        'symbol': 'TCS',
        'name': 'Tata Consultancy Services Ltd.',
        'sector': 'IT',
        'marketCap': 12000000000,
        'pe': 30.0,
        'pb': 8.0,
        'dividend': 1.0,
      },
      {
        'symbol': 'INFY',
        'name': 'Infosys Ltd.',
        'sector': 'IT',
        'marketCap': 8000000000,
        'pe': 28.0,
        'pb': 6.0,
        'dividend': 0.8,
      },
      {
        'symbol': 'HDFCBANK',
        'name': 'HDFC Bank Ltd.',
        'sector': 'Banking',
        'marketCap': 7000000000,
        'pe': 22.0,
        'pb': 4.0,
        'dividend': 1.2,
      },
      {
        'symbol': 'ICICIBANK',
        'name': 'ICICI Bank Ltd.',
        'sector': 'Banking',
        'marketCap': 6000000000,
        'pe': 24.0,
        'pb': 3.8,
        'dividend': 1.0,
      },
      {
        'symbol': 'SBIN',
        'name': 'State Bank of India',
        'sector': 'Banking',
        'marketCap': 4000000000,
        'pe': 15.0,
        'pb': 1.5,
        'dividend': 2.0,
      },
      {
        'symbol': 'BHARTIARTL',
        'name': 'Bharti Airtel Ltd.',
        'sector': 'Telecom',
        'marketCap': 5000000000,
        'pe': 40.0,
        'pb': 4.5,
        'dividend': 0.4,
      },
      {
        'symbol': 'WIPRO',
        'name': 'Wipro Ltd.',
        'sector': 'IT',
        'marketCap': 2000000000,
        'pe': 25.0,
        'pb': 3.2,
        'dividend': 0.6,
      },
      {
        'symbol': 'AXISBANK',
        'name': 'Axis Bank Ltd.',
        'sector': 'Banking',
        'marketCap': 2500000000,
        'pe': 20.0,
        'pb': 3.0,
        'dividend': 1.5,
      },
      {
        'symbol': 'KOTAKBANK',
        'name': 'Kotak Mahindra Bank Ltd.',
        'sector': 'Banking',
        'marketCap': 3000000000,
        'pe': 26.0,
        'pb': 4.2,
        'dividend': 0.8,
      },
      {
        'symbol': 'ITC',
        'name': 'ITC Ltd.',
        'sector': 'FMCG',
        'marketCap': 4500000000,
        'pe': 28.0,
        'pb': 8.0,
        'dividend': 2.5,
      },
      {
        'symbol': 'SUNPHARMA',
        'name': 'Sun Pharmaceutical Industries Ltd.',
        'sector': 'Pharma',
        'marketCap': 3500000000,
        'pe': 32.0,
        'pb': 4.5,
        'dividend': 0.7,
      },
      {
        'symbol': 'BAJAJFINSV',
        'name': 'Bajaj Finance Ltd.',
        'sector': 'Finance',
        'marketCap': 4000000000,
        'pe': 45.0,
        'pb': 7.0,
        'dividend': 0.5,
      },
      {
        'symbol': 'HINDUNILVR',
        'name': 'Hindustan Unilever Ltd.',
        'sector': 'FMCG',
        'marketCap': 5500000000,
        'pe': 65.0,
        'pb': 15.0,
        'dividend': 1.0,
      },
      {
        'symbol': 'MARUTI',
        'name': 'Maruti Suzuki India Ltd.',
        'sector': 'Auto',
        'marketCap': 7500000000,
        'pe': 40.0,
        'pb': 5.5,
        'dividend': 1.2,
      },
      {
        'symbol': 'ASIANPAINT',
        'name': 'Asian Paints Ltd.',
        'sector': 'Construction',
        'marketCap': 6000000000,
        'pe': 70.0,
        'pb': 12.0,
        'dividend': 0.9,
      },
      {
        'symbol': 'TITAN',
        'name': 'Titan Company Ltd.',
        'sector': 'Construction',
        'marketCap': 2500000000,
        'pe': 55.0,
        'pb': 8.0,
        'dividend': 0.6,
      },
      {
        'symbol': 'ULTRACEMCO',
        'name': 'UltraTech Cement Ltd.',
        'sector': 'Construction',
        'marketCap': 1800000000,
        'pe': 35.0,
        'pb': 4.8,
        'dividend': 1.0,
      },
      {
        'symbol': 'TATAMOTORS',
        'name': 'Tata Motors Ltd.',
        'sector': 'Auto',
        'marketCap': 4500000000,
        'pe': 18.0,
        'pb': 2.5,
        'dividend': 0.4,
      },
      {
        'symbol': 'BAJAJ-AUTO',
        'name': 'Bajaj Auto Ltd.',
        'sector': 'Auto',
        'marketCap': 1200000000,
        'pe': 22.0,
        'pb': 4.0,
        'dividend': 1.5,
      },
      {
        'symbol': 'NESTLEIND',
        'name': 'Nestle India Ltd.',
        'sector': 'FMCG',
        'marketCap': 1800000000,
        'pe': 75.0,
        'pb': 20.0,
        'dividend': 1.2,
      },
      {
        'symbol': 'POWERGRID',
        'name': 'Power Grid Corporation of India Ltd.',
        'sector': 'Power',
        'marketCap': 1100000000,
        'pe': 20.0,
        'pb': 2.2,
        'dividend': 4.0,
      },
      {
        'symbol': 'NTPC',
        'name': 'NTPC Ltd.',
        'sector': 'Power',
        'marketCap': 1600000000,
        'pe': 15.0,
        'pb': 1.8,
        'dividend': 3.5,
      },
      {
        'symbol': 'ADANIENT',
        'name': 'Adani Enterprises Ltd.',
        'sector': 'Metals',
        'marketCap': 500000000,
        'pe': 60.0,
        'pb': 5.0,
        'dividend': 0.2,
      },
      {
        'symbol': 'ADANIPORTS',
        'name': 'Adani Ports and Special Economic Zone Ltd.',
        'sector': 'Construction',
        'marketCap': 750000000,
        'pe': 45.0,
        'pb': 4.0,
        'dividend': 0.5,
      },
      {
        'symbol': 'ADANIGREEN',
        'name': 'Adani Green Energy Ltd.',
        'sector': 'Power',
        'marketCap': 400000000,
        'pe': 80.0,
        'pb': 6.0,
        'dividend': 0.1,
      },
      {
        'symbol': 'DMART',
        'name': 'Avenue Supermarts Ltd.',
        'sector': 'Retail',
        'marketCap': 1800000000,
        'pe': 85.0,
        'pb': 12.0,
        'dividend': 0.3,
      },
      {
        'symbol': 'ZOMATO',
        'name': 'Zomato Ltd.',
        'sector': 'Food Delivery',
        'marketCap': 1000000000,
        'pe': 120.0,
        'pb': 3.5,
        'dividend': 0.0,
      },
      {
        'symbol': 'PAYTM',
        'name': 'Paytm Ltd.',
        'sector': 'FinTech',
        'marketCap': 500000000,
        'pe': -5.0,
        'pb': 2.0,
        'dividend': 0.0,
      },
      {
        'symbol': 'OYO',
        'name': 'OYO Rooms',
        'sector': 'Hospitality',
        'marketCap': 400000000,
        'pe': -10.0,
        'pb': 1.5,
        'dividend': 0.0,
      },
    ];

    for (var data in stockData) {
      final basePrice = 100 + (random % 5000) / 10;
      final change = (random % 100 - 50) / 10;
      final price = basePrice + change;
      final changePercent = (change / basePrice) * 100;
      _stocks.add(
        Stock(
          symbol: data['symbol'] as String,
          name: data['name'] as String,
          price: price,
          change: change,
          changePercent: changePercent,
          isPositive: change >= 0,
          sector: data['sector'] as String,
          marketCap: (data['marketCap'] as int).toDouble(),
          pe: data['pe'] as double,
          pb: data['pb'] as double,
          dividendYield: data['dividend'] as double,
        ),
      );
    }
  }

  @override
  Future<List<Stock>> getStocks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_stocks);
  }
}
