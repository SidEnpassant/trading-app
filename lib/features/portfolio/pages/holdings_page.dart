import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_state.dart';
import '../bloc/portfolio_bloc.dart';
import '../widgets/holding_tile.dart';

class HoldingsPage extends StatelessWidget {
  const HoldingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Holdings')),
      body: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PortfolioLoaded) {
            final holdings = state.holdings;
            return ListView.builder(
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
            );
          } else if (state is PortfolioError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
