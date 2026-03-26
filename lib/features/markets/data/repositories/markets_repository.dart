import 'package:trading/features/markets/data/datasources/markets_datasource.dart';
import 'package:trading/features/markets/data/models/stock.dart';
import 'package:trading/features/markets/data/models/stock_filter.dart';

abstract class MarketsRepository {
  Future<List<Stock>> getStocks();
  List<Stock> searchStocks(String query, List<Stock> allStocks);
  List<Stock> applyFilter(List<Stock> stocks, Sector filter);
  List<Stock> sortStocks(List<Stock> stocks, SortBy sortBy);
}

class MarketsRepositoryImpl implements MarketsRepository {
  final MarketsDataSource dataSource;

  MarketsRepositoryImpl(this.dataSource);

  @override
  Future<List<Stock>> getStocks() async {
    return await dataSource.getStocks();
  }

  @override
  List<Stock> searchStocks(String query, List<Stock> allStocks) {
    final lowerQuery = query.toLowerCase();
    return allStocks.where((stock) {
      return stock.name.toLowerCase().contains(lowerQuery) ||
          stock.symbol.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  List<Stock> applyFilter(List<Stock> stocks, Sector filter) {
    if (filter == Sector.all) return stocks;
    return stocks.where((stock) => stock.sector == filter.name).toList();
  }

  @override
  List<Stock> sortStocks(List<Stock> stocks, SortBy sortBy) {
    final sorted = List<Stock>.from(stocks);
    switch (sortBy) {
      case SortBy.priceAsc:
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortBy.priceDesc:
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortBy.changePercentDesc:
        sorted.sort((a, b) => b.changePercent.compareTo(a.changePercent));
        break;
      case SortBy.changePercentAsc:
        sorted.sort((a, b) => a.changePercent.compareTo(b.changePercent));
        break;
      case SortBy.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortBy.nameDesc:
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortBy.marketCapAsc:
        sorted.sort((a, b) => a.marketCap.compareTo(b.marketCap));
        break;
      case SortBy.marketCapDesc:
        sorted.sort((a, b) => b.marketCap.compareTo(a.marketCap));
        break;
      case SortBy.name:
        // TODO: Handle this case.
        throw UnimplementedError();
      case SortBy.marketCap:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    return sorted;
  }
}
