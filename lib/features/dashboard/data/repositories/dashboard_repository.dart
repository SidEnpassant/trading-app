import 'package:trading/features/dashboard/data/models/market_index.dart';
import 'package:trading/features/dashboard/data/models/stock_brief.dart';
import 'package:trading/features/dashboard/data/models/portfolio_summary.dart';

abstract class DashboardRepository {
  Future<List<MarketIndex>> getIndices();
  Stream<List<MarketIndex>> getIndicesStream();
  Future<List<StockBrief>> getTopGainers();
  Future<List<StockBrief>> getTopLosers();
  Future<PortfolioSummary> getPortfolioSummary();
}
