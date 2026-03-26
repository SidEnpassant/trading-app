import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trading/features/orders/data/models/order.dart';
import 'package:trading/features/orders/data/models/order_type.dart';
import 'package:trading/features/orders/data/models/order_status.dart';
import 'package:trading/features/orders/data/repositories/orders_repository.dart';
import 'package:trading/features/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:trading/features/portfolio/data/models/allocation_data.dart';
import 'package:trading/features/portfolio/data/models/holding.dart';
import 'package:trading/features/portfolio/data/models/portfolio_pnl.dart';
import 'package:trading/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:trading/features/watchlist/data/repositories/watchlist_repository.dart';
import 'package:trading/features/orders/data/models/stock_brief.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioDataSource dataSource;
  final WatchlistRepository watchlistRepository;
  final OrdersRepository ordersRepository;

  PortfolioRepositoryImpl({
    required this.dataSource,
    required this.watchlistRepository,
    required this.ordersRepository,
  });

  @override
  Future<List<Holding>> getHoldings() async {
    // Get completed buy orders
    final allOrders = await ordersRepository.getAllOrders();
    final buyOrders = allOrders
        .where(
          (o) =>
              o.orderType == OrderType.market &&
              (o.status == OrderStatus.completed ||
                  o.status == OrderStatus.open),
        )
        .toList();

    // Group by stock symbol
    final Map<String, List<Order>> ordersBySymbol = {};
    for (var order in buyOrders) {
      ordersBySymbol.putIfAbsent(order.stock.symbol, () => []).add(order);
    }

    // Get market data from watchlist (includes currentPrice and prevClose)
    final watchlistStocks = await watchlistRepository.getWatchlist();
    final Map<String, StockBrief> marketDataMap = {
      for (var s in watchlistStocks) s.symbol: s,
    };

    final holdings = <Holding>[];
    for (var entry in ordersBySymbol.entries) {
      final symbol = entry.key;
      final orders = entry.value;

      // Compute quantity and average price
      int totalQty = 0;
      double totalCost = 0;
      for (var order in orders) {
        totalQty += order.quantity;
        totalCost += order.quantity * order.price;
      }
      double avgPrice = totalQty > 0 ? totalCost / totalQty : 0;

      // Get market data
      final stockBrief = marketDataMap[symbol];
      if (stockBrief == null ||
          stockBrief.currentPrice == null ||
          stockBrief.prevClose == null) {
        continue; // Skip if no market data
      }

      final currentPrice = stockBrief.currentPrice!;
      final prevClose = stockBrief.prevClose!;
      final dayPnl = (currentPrice - prevClose) * totalQty;
      final totalPnl = (currentPrice - avgPrice) * totalQty;

      holdings.add(
        Holding(
          stock: stockBrief,
          quantity: totalQty,
          avgPrice: avgPrice,
          currentPrice: currentPrice,
          dayPnl: dayPnl,
          totalPnl: totalPnl,
        ),
      );
    }
    return holdings;
  }

  @override
  Future<PortfolioPnl> getPortfolio() async {
    final holdings = await getHoldings();
    double totalInvestment = 0;
    double currentValue = 0;
    double dayPnl = 0;
    double overallPnl = 0;

    for (var h in holdings) {
      totalInvestment += h.quantity * h.avgPrice;
      currentValue += h.quantity * h.currentPrice;
      dayPnl += h.dayPnl;
      overallPnl += h.totalPnl;
    }

    double dayPnlPercent = totalInvestment != 0
        ? (dayPnl / totalInvestment) * 100
        : 0;
    double overallPnlPercent = totalInvestment != 0
        ? (overallPnl / totalInvestment) * 100
        : 0;

    return PortfolioPnl(
      totalInvestment: totalInvestment,
      currentValue: currentValue,
      dayPnl: dayPnl,
      dayPnlPercent: dayPnlPercent,
      overallPnl: overallPnl,
      overallPnlPercent: overallPnlPercent,
    );
  }

  @override
  Future<List<AllocationData>> getAllocation() async {
    final holdings = await getHoldings();
    final totalValue = holdings.fold(
      0.0,
      (sum, h) => sum + (h.quantity * h.currentPrice),
    );
    if (totalValue == 0) return [];

    final Map<String, double> labelValues = {};
    for (var h in holdings) {
      final value = h.quantity * h.currentPrice;
      labelValues[h.stock.symbol] = (labelValues[h.stock.symbol] ?? 0) + value;
    }

    const threshold = 0.05; // 5%
    double othersValue = 0;
    final mainList = <AllocationData>[];
    final othersList = <AllocationData>[];
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    int colorIndex = 0;

    for (var entry in labelValues.entries) {
      final proportion = entry.value / totalValue;
      if (proportion < threshold) {
        othersValue += entry.value;
      } else {
        final color = colors[colorIndex % colors.length];
        mainList.add(
          AllocationData(label: entry.key, value: entry.value, color: color),
        );
        colorIndex++;
      }
    }

    if (othersValue > 0) {
      othersList.add(
        AllocationData(label: 'Others', value: othersValue, color: Colors.grey),
      );
    }

    return [...mainList, ...othersList];
  }
}
