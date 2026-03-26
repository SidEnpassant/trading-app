import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading/features/dashboard/bloc/dashboard_event.dart';
import 'package:trading/features/dashboard/pages/dashboard_page.dart';
import 'package:trading/features/markets/bloc/markets_bloc.dart';
import 'package:trading/features/markets/bloc/markets_event.dart';
import 'package:trading/features/markets/pages/markets_page.dart';
import 'package:trading/features/orders/bloc/orders_event.dart';
import 'package:trading/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:trading/features/orders/bloc/orders_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_event.dart';
import 'package:trading/features/portfolio/pages/portfolio_page.dart';
import 'package:trading/features/orders/pages/orders_page.dart';
import 'package:trading/features/profile/pages/profile_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardPage(),
    MarketsPage(),
    PortfolioPage(),
    OrdersPage(),
    ProfilePage(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Markets',
    'Portfolio',
    'Orders',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    // Load initial data for each bloc
    Future.microtask(() {
      if (mounted) {
        context.read<DashboardBloc>().add(LoadDashboard());
        context.read<MarketsBloc>().add(LoadStocks());
        context.read<PortfolioBloc>().add(LoadPortfolio());
        context.read<OrdersBloc>().add(LoadOrders());
        // Profile not ready yet
        // context.read<ProfileBloc>().add(LoadProfile());
      }
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_currentIndex])),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Markets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
