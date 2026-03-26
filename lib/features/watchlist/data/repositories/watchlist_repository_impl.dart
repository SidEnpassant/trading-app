import 'package:trading/features/orders/data/models/stock_brief.dart';
import 'package:trading/features/watchlist/data/datasources/watchlist_datasource.dart';
import 'package:trading/features/watchlist/data/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistDataSource datasource;
  final dynamic marketsRepository; // Not used in this stub implementation

  WatchlistRepositoryImpl({
    required this.datasource,
    required this.marketsRepository,
  });

  @override
  Future<List<StockBrief>> getWatchlist() async {
    // Return hardcoded watchlist with prevClose for P&L calculation
    return [
      StockBrief(
        symbol: 'RELIANCE',
        name: 'Reliance Industries',
        currentPrice: 2500.0,
        prevClose: 2480.0,
      ),
      StockBrief(
        symbol: 'TCS',
        name: 'Tata Consultancy',
        currentPrice: 3500.0,
        prevClose: 3480.0,
      ),
      StockBrief(
        symbol: 'HDFCBANK',
        name: 'HDFC Bank',
        currentPrice: 1800.0,
        prevClose: 1790.0,
      ),
      StockBrief(
        symbol: 'INFY',
        name: 'Infosys',
        currentPrice: 1200.0,
        prevClose: 1190.0,
      ),
      StockBrief(
        symbol: 'ICICIBANK',
        name: 'ICICI Bank',
        currentPrice: 950.0,
        prevClose: 940.0,
      ),
    ];
  }

  @override
  Future<void> addToWatchlist(StockBrief stock) async {
    await datasource.addSymbol(stock.symbol);
  }

  @override
  Future<void> removeFromWatchlist(String symbol) async {
    await datasource.removeSymbol(symbol);
  }
}
