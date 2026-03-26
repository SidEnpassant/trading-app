import 'package:equatable/equatable.dart';

class BidAsk extends Equatable {
  final double price;
  final int quantity;

  const BidAsk({required this.price, required this.quantity});

  @override
  List<Object?> get props => [price, quantity];
}

class OrderBook extends Equatable {
  final List<BidAsk> bids;
  final List<BidAsk> asks;

  const OrderBook({required this.bids, required this.asks});

  @override
  List<Object?> get props => [bids, asks];
}
