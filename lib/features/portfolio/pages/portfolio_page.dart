import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_event.dart';
import 'package:trading/features/portfolio/bloc/portfolio_state.dart';
import 'package:trading/features/portfolio/data/models/holding.dart';
import 'package:trading/features/portfolio/data/models/portfolio_pnl.dart';
import 'package:trading/features/portfolio/data/models/allocation_data.dart';
import 'package:trading/features/portfolio/pages/holdings_page.dart';
import 'package:trading/features/portfolio/widgets/portfolio_header.dart';
import 'package:trading/features/portfolio/widgets/allocation_pie_chart.dart';
import 'package:trading/features/portfolio/widgets/holding_tile.dart';
import 'package:trading/features/portfolio/widgets/pnl_card.dart';
import 'package:trading/core/utils/currency_formatter.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PortfolioLoaded) {
            final holdings = state.holdings;
            final summary = state.summary;
            final allocations = _computeAllocations(holdings);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PortfolioHeader(summary: summary),
                  const SizedBox(height: 20),
                  const Text(
                    'Allocation',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: AllocationPieChart(allocations: allocations),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Holdings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HoldingsPage(),
                            ),
                          );
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: holdings.length,
                    itemBuilder: (context, index) {
                      final holding = holdings[index];
                      return HoldingTile(
                        holding: holding,
                        onTap: () {
                          // TODO: Navigate to stock details
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is PortfolioError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  List<AllocationData> _computeAllocations(List<Holding> holdings) {
    double totalValue = holdings.fold(
      0,
      (sum, h) => sum + (h.quantity * h.currentPrice),
    );
    if (totalValue == 0) return [];
    Map<String, double> labelValues = {};
    for (var h in holdings) {
      double value = h.quantity * h.currentPrice;
      labelValues[h.stock.symbol] = (labelValues[h.stock.symbol] ?? 0) + value;
    }
    const threshold = 0.05;
    double othersValue = 0;
    List<AllocationData> mainList = [];
    List<AllocationData> othersList = [];
    List<Color> colors = [
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
      double proportion = entry.value / totalValue;
      if (proportion < threshold) {
        othersValue += entry.value;
      } else {
        mainList.add(
          AllocationData(
            label: entry.key,
            value: entry.value,
            color: colors[colorIndex % colors.length],
          ),
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
