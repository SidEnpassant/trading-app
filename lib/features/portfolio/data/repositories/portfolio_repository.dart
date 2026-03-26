import '../models/portfolio_pnl.dart';
import '../models/holding.dart';
import '../models/allocation_data.dart';

abstract class PortfolioRepository {
  Future<PortfolioPnl> getPortfolio();
  Future<List<Holding>> getHoldings();
  Future<List<AllocationData>> getAllocation();
}
