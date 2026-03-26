import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/utils/formatting.dart';
import 'package:trading/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading/features/dashboard/bloc/dashboard_event.dart';
import 'package:trading/features/dashboard/bloc/dashboard_state.dart';
import 'package:trading/features/dashboard/widgets/index_card.dart';
import 'package:trading/features/dashboard/widgets/stock_list_item.dart';
import 'package:trading/features/dashboard/widgets/portfolio_summary_card.dart';
import 'package:trading/features/dashboard/widgets/quick_actions.dart';
import 'package:trading/shared/widgets/custom_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(LoadDashboard());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Market Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.indices.length,
                          itemBuilder: (context, index) {
                            final idx = state.indices[index];
                            return IndexCard(index: idx);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Top Gainers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.topGainers
                          .take(5)
                          .map((stock) => StockListItem(stock: stock)),
                      const SizedBox(height: 16),
                      const Text(
                        'Top Losers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...state.topLosers
                          .take(5)
                          .map((stock) => StockListItem(stock: stock)),
                      const SizedBox(height: 24),
                      PortfolioSummaryCard(summary: state.portfolioSummary),
                      const SizedBox(height: 24),
                      const QuickActions(),
                    ],
                  );
                } else if (state is DashboardError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
