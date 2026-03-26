import 'package:trading/features/dashboard/data/datasources/market_datasource.dart';
import 'package:trading/features/dashboard/data/models/market_index.dart';
import 'package:trading/features/dashboard/data/models/stock_brief.dart';
import 'package:trading/features/dashboard/data/models/portfolio_summary.dart';
import 'package:trading/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:trading/features/watchlist/data/repositories/watchlist_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final MarketDataSource marketDataSource;
  final WatchlistRepository watchlistRepository;

  DashboardRepositoryImpl({
    required this.marketDataSource,
    required this.watchlistRepository,
  });

  @override
  Future<List<MarketIndex>> getIndices() async {
    return await marketDataSource.getInitialIndices();
  }

  @override
  Stream<List<MarketIndex>> getIndicesStream() {
    return marketDataSource.getIndicesStream();
  }

  @override
  Future<List<StockBrief>> getTopGainers() async {
    final indices = await marketDataSource.getTopGainers();
    return indices
        .map(
          (idx) => StockBrief(
            symbol: idx.symbol,
            name: idx.name,
            currentPrice: idx.value,
            change: idx.change,
            changePercent: idx.changePercent,
            isPositive: idx.isPositive,
          ),
        )
        .toList();
  }

  @override
  Future<List<StockBrief>> getTopLosers() async {
    final indices = await marketDataSource.getTopLosers();
    return indices
        .map(
          (idx) => StockBrief(
            symbol: idx.symbol,
            name: idx.name,
            currentPrice: idx.value,
            change: idx.change,
            changePercent: idx.changePercent,
            isPositive: idx.isPositive,
          ),
        )
        .toList();
  }

  @override
  Future<PortfolioSummary> getPortfolioSummary() async {
    return const PortfolioSummary(
      totalValue: 0,
      dayPnl: 0,
      overallPnl: 0,
      allocation: [],
    );
  }
}
