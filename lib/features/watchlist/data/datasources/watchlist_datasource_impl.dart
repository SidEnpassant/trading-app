import 'package:trading/features/watchlist/data/datasources/watchlist_datasource.dart';

class WatchlistDataSourceImpl implements WatchlistDataSource {
  final List<String> _symbols = [
    'RELIANCE',
    'TCS',
    'HDFCBANK',
    'INFY',
    'ICICIBANK',
  ];

  @override
  Future<List<String>> getWatchlistSymbols() async {
    return List.unmodifiable(_symbols);
  }

  @override
  Future<void> addSymbol(String symbol) async {
    if (!_symbols.contains(symbol)) {
      _symbols.add(symbol);
    }
  }

  @override
  Future<void> removeSymbol(String symbol) async {
    _symbols.remove(symbol);
  }
}
