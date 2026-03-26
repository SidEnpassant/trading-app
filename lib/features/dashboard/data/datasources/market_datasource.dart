import 'dart:async';
import 'dart:math';
import 'package:trading/features/dashboard/data/models/market_index.dart';

abstract class MarketDataSource {
  Stream<List<MarketIndex>> getIndicesStream();
  Future<List<MarketIndex>> getInitialIndices();
  List<MarketIndex> getTopGainers();
  List<MarketIndex> getTopLosers();
}

class MarketDataSourceImpl implements MarketDataSource {
  final _indexController = StreamController<List<MarketIndex>>.broadcast();
  final List<MarketIndex> _indices = [];
  final Random _random = Random();

  MarketDataSourceImpl() {
    _initializeIndices();
    _startStreaming();
  }

  void _initializeIndices() {
    _indices.addAll([
      MarketIndex(
        name: 'NIFTY 50',
        symbol: 'NIFTY',
        value: 22500.0,
        change: 0.0,
        changePercent: 0.0,
        isPositive: true,
      ),
      MarketIndex(
        name: 'BANK NIFTY',
        symbol: 'BANKNIFTY',
        value: 47500.0,
        change: 0.0,
        changePercent: 0.0,
        isPositive: true,
      ),
      MarketIndex(
        name: 'SENSEX',
        symbol: 'SENSEX',
        value: 75000.0,
        change: 0.0,
        changePercent: 0.0,
        isPositive: true,
      ),
    ]);
  }

  void _startStreaming() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      for (int i = 0; i < _indices.length; i++) {
        final index = _indices[i];
        final change = (_random.nextDouble() - 0.5) * 20;
        final newValue = index.value + change;
        final changePercent = (change / index.value) * 100;
        _indices[i] = index.copyWith(
          value: newValue,
          change: change,
          changePercent: changePercent,
          isPositive: change >= 0,
        );
      }
      _indexController.add(List.unmodifiable(_indices));
      return true;
    });
  }

  @override
  Stream<List<MarketIndex>> getIndicesStream() {
    return _indexController.stream;
  }

  @override
  Future<List<MarketIndex>> getInitialIndices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_indices);
  }

  @override
  List<MarketIndex> getTopGainers() {
    final all = List<MarketIndex>.from(_indices);
    all.sort((a, b) => b.changePercent.compareTo(a.changePercent));
    return all.take(10).toList();
  }

  @override
  List<MarketIndex> getTopLosers() {
    final all = List<MarketIndex>.from(_indices);
    all.sort((a, b) => a.changePercent.compareTo(b.changePercent));
    return all.take(10).toList();
  }
}
