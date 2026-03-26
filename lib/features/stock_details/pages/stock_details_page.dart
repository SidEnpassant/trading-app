import 'package:flutter/material.dart';

class StockDetailsPage extends StatelessWidget {
  final String symbol;

  const StockDetailsPage({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(symbol)),
      body: Center(
        child: Text(
          'Stock Details for $symbol',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
