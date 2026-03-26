import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading/core/di/service_locator.dart';
import 'package:trading/core/theme/app_theme.dart';
import 'package:trading/features/auth/bloc/auth_state.dart';
import 'package:trading/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading/features/markets/bloc/markets_bloc.dart';
import 'package:trading/features/orders/bloc/orders_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:trading/features/stock_details/pages/stock_details_page.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_event.dart';
import 'features/auth/pages/login_page.dart';
import 'features/app/pages/main_shell.dart';

void main() {
  init();
  runApp(const TradingApp());
}

class TradingApp extends StatelessWidget {
  const TradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<DashboardBloc>(create: (_) => sl<DashboardBloc>()),
        BlocProvider<MarketsBloc>(create: (_) => sl<MarketsBloc>()),
        BlocProvider<PortfolioBloc>(create: (_) => sl<PortfolioBloc>()),
        BlocProvider<OrdersBloc>(create: (_) => sl<OrdersBloc>()),
      ],
      child: MaterialApp(
        title: 'Trading App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const AuthWrapper(),
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/stockDetails':
        final symbol = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => StockDetailsPage(symbol: symbol),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return const MainShell();
        }
        return const LoginPage();
      },
    );
  }
}
