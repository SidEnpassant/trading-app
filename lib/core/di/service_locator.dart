import 'package:get_it/get_it.dart';

// Auth
import 'package:trading/features/auth/data/repositories/auth_repository.dart';
import 'package:trading/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:trading/features/auth/data/datasources/auth_datasource.dart';

// Dashboard
import 'package:trading/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:trading/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:trading/features/dashboard/data/datasources/market_datasource.dart';

// Markets
import 'package:trading/features/markets/data/repositories/markets_repository.dart';
import 'package:trading/features/markets/data/datasources/markets_datasource.dart';

// Stock Details
import 'package:trading/features/stock_details/data/repositories/stock_details_repository.dart';
import 'package:trading/features/stock_details/data/repositories/stock_details_repository_impl.dart';
import 'package:trading/features/stock_details/data/datasources/chart_datasource.dart';

// Portfolio
import 'package:trading/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:trading/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:trading/features/portfolio/data/datasources/portfolio_datasource.dart';
import 'package:trading/features/portfolio/data/datasources/portfolio_datasource_impl.dart';

// Orders
import 'package:trading/features/orders/data/repositories/orders_repository.dart';
import 'package:trading/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:trading/features/orders/data/datasources/orders_datasource.dart';

// Watchlist
import 'package:trading/features/watchlist/data/repositories/watchlist_repository.dart';
import 'package:trading/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:trading/features/watchlist/data/datasources/watchlist_datasource.dart';
import 'package:trading/features/watchlist/data/datasources/watchlist_datasource_impl.dart';

// Profile
import 'package:trading/features/profile/data/repositories/profile_repository.dart';
import 'package:trading/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:trading/features/profile/data/datasources/profile_datasource.dart';

// BLoCs
import 'package:trading/features/auth/bloc/auth_bloc.dart';
import 'package:trading/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:trading/features/markets/bloc/markets_bloc.dart';
import 'package:trading/features/portfolio/bloc/portfolio_bloc.dart';
import 'package:trading/features/orders/bloc/orders_bloc.dart';
import 'package:trading/features/profile/bloc/profile_bloc.dart';

final GetIt sl = GetIt.instance;

void init() {
  // DataSources
  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  sl.registerLazySingleton<MarketDataSource>(() => MarketDataSourceImpl());
  sl.registerLazySingleton<MarketsDataSource>(() => MarketsDataSourceImpl());
  sl.registerLazySingleton<ChartDataSource>(() => ChartDataSource());
  sl.registerLazySingleton<PortfolioDataSource>(
    () => PortfolioDataSourceImpl(),
  );
  sl.registerLazySingleton<OrdersDataSource>(() => OrdersDataSourceImpl());
  sl.registerLazySingleton<WatchlistDataSource>(
    () => WatchlistDataSourceImpl(),
  );
  // sl.registerLazySingleton<ProfileDataSource>(() => ProfileDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<MarketsRepository>(
    () => MarketsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(ordersDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: sl()),
  );

  sl.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(datasource: sl(), marketsRepository: sl()),
  );

  sl.registerLazySingleton<StockDetailsRepository>(
    () => StockDetailsRepositoryImpl(chartDataSource: sl()),
  );

  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(
      marketDataSource: sl(),
      watchlistRepository: sl(),
    ),
  );

  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(
      dataSource: sl(),
      watchlistRepository: sl(),
      ordersRepository: sl(),
    ),
  );

  // ProfileRepository temporarily disabled - profile module is WIP
  // sl.registerLazySingleton<ProfileRepository>(
  //   () => ProfileRepositoryImpl(datasource: sl()),
  // );

  // BLoCs
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc());
  sl.registerLazySingleton<DashboardBloc>(() => DashboardBloc());
  sl.registerLazySingleton<MarketsBloc>(() => MarketsBloc(sl()));
  sl.registerLazySingleton<PortfolioBloc>(() => PortfolioBloc(sl()));
  sl.registerLazySingleton<OrdersBloc>(() => OrdersBloc());
  // StockDetailsBloc and ProfileBloc skipped - not yet fully implemented
}
