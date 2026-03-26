# High-Performance Trading App Implementation Plan

## Context
Building a professional-grade trading app similar to Groww with complete BLoC state management, responsive UI, and dummy data. The project already has a basic Flutter structure with `flutter_bloc` dependency and a dark theme stub.

## Architecture Overview

**Feature-First Structure:**
```
lib/
├── main.dart (entry point, routing, DI setup)
├── core/
│   ├── theme/app_theme.dart (existing - integrate)
│   ├── utils/ (constants, formatting, validators)
│   └── di/service_locator.dart
├── features/
│   ├── auth/
│   ├── dashboard/
│   ├── markets/
│   ├── stock_details/
│   ├── portfolio/
│   ├── orders/
│   ├── watchlist/
│   ├── profile/
│   └── app/ (bottom nav shell, app bar, navigation)
└── shared/
    ├── widgets/ (custom_card, shimmer, empty_state)
    └── extensions/
```

## Implementation Phases

### Phase 1: Infrastructure Setup (1-2 hours)

**Files to create/modify:**

1. **Update `pubspec.yaml`** - Add required dependencies:
   - `fl_chart: ^0.68.0` (charts)
   - `cached_network_image: ^3.3.1` (image caching)
   - `shared_preferences: ^2.2.3` (local storage)
   - `animations: ^2.0.11` (transitions)
   - `get_it: ^7.6.4` (dependency injection)
   - `rxdart: ^0.27.7` (stream operators)

2. **Create `lib/core/di/service_locator.dart`**:
   - Initialize GetIt service locator
   - Register all repositories and blocs with lazy singletons/factory

3. **Create `lib/core/utils/`**:
   - `constants.dart` - App-wide constants (colors, API endpoints placeholder, mock data seeds)
   - `formatting.dart` - Currency formatters, percentage formatters, date formatters
   - `logger.dart` - Simple logging utility

4. **Create `lib/shared/widgets/`**:
   - `custom_card.dart` - Reusable card with border radius, padding
   - `shimmer_loading.dart` - Skeleton loading effect
   - `empty_state.dart` - Empty list illustration/text
   - `error_state.dart` - Error display with retry button

5. **Rewrite `lib/main.dart`**:
   - Initialize service locator
   - Set up GoRouter or simple onGenerateRoute
   - Integrate `AppTheme.darkTheme`
   - Wrap with `BlocProvider` for AuthBloc
   - Check auth state & route to login or MainShell

### Phase 2: Base BLoC Pattern (30 mins)

Create abstract base classes to standardize BLoC implementation:

- `lib/features/base/base_bloc.dart` - Common BLoC functionality
- `lib/features/base/base_event.dart` - Extend Equatable
- `lib/features/base/base_state.dart` - Extend Equatable with loading/error states

**Pattern template to replicate:**
```dart
abstract class BaseEvent extends Equatable { const BaseEvent(); }
abstract class BaseState extends Equatable { const BaseState(); }

class InitialState extends BaseState { const InitialState(); }
class LoadingState extends BaseState { const LoadingState(); }
class ErrorState extends BaseState {
  final String message;
  const ErrorState(this.message);
}
```

### Phase 3: Authentication Feature (1.5 hours)

**Purpose:** Simple login/signup with validation and session persistence.

**Files:**
```
lib/features/auth/
├── bloc/
│   ├── auth_bloc.dart
│   ├── auth_event.dart (LoginEvent, SignupEvent, LogoutEvent)
│   └── auth_state.dart (AuthInitial, AuthLoading, AuthSuccess, AuthError)
├── data/
│   ├── models/
│   │   ├── user.dart
│   │   └── login_request.dart
│   ├── repositories/
│   │   └── auth_repository.dart (abstract + impl)
│   └── datasources/
│       └── auth_datasource.dart (dummy validation, 1 sec delay)
├── pages/
│   ├── login_page.dart
│   └── signup_page.dart
└── widgets/
    ├── auth_text_field.dart
    └── auth_button.dart
```

**Key decisions:**
- Use `shared_preferences` to store login token
- Simple validation: email format, password min 6 chars
- Dummy credentials: any email@domain.com / password123 works
- On success: navigate to MainShell (dashboard tab)
- Show error SnackBar on failure

**Performance:** Validate on field change, debounce submit button

### Phase 4: Dashboard Feature (2 hours)

**Purpose:** Market overview with real-time index updates, top gainers/losers, portfolio summary, quick actions.

**Files:**
```
lib/features/dashboard/
├── bloc/
│   ├── dashboard_bloc.dart
│   ├── dashboard_event.dart (LoadDashboard, RefreshMarket)
│   └── dashboard_state.dart (with indices, topGainers, topLosers, portfolioSummary)
├── data/
│   ├── models/
│   │   ├── market_index.dart (name, symbol, value, change%, isPositive)
│   │   ├── stock_brief.dart (symbol, name, price, change)
│   │   └── portfolio_summary.dart (totalValue, dayPnl, overallPnl, allocation)
│   ├── repositories/
│   │   └── dashboard_repository.dart
│   └── datasources/
│       └── market_datasource.dart (StreamController simulating 3-second updates)
├── pages/
│   └── dashboard_page.dart (with RefreshIndicator)
└── widgets/
    ├── index_card.dart (NIFTY, BANK NIFTY cards with animated colors)
    ├── stock_list_item.dart (reusable for gainers/losers)
    ├── portfolio_summary_card.dart
    ├── quick_actions.dart (grid of icons: Buy, Sell, Orders, Watchlist, Portfolio, Profile)
    └── market_overview_chart.dart (mini sparkline using fl_chart)
```

**Key decisions:**
- Stream real-time index updates every 3 seconds with random ±10 point changes
- Mock portfolio: show user's holdings aggregated value
- Use `StreamBuilder` in BLoC to listen to market streams
- Pull-to-refresh triggers full dashboard reload

**Performance:**
- Throttle stream emissions (avoid UI jitter)
- Use `BehaviorSubject` for latest value replay
- `ListView` with `itemExtent: 72` for fixed-height cards
- `IndexedStack` in MainShell to preserve dashboard state on tab switch

### Phase 5: Markets/Discover Feature (2 hours)

**Purpose:** Browse/search all stocks with filters.

**Files:**
```
lib/features/markets/
├── bloc/
│   ├── markets_bloc.dart
│   ├── markets_event.dart (LoadStocks, SearchStocks, ApplyFilter, ChangeSort)
│   └── markets_state.dart (with filtered stock list, search query, active filters)
├── data/
│   ├── models/
│   │   ├── stock.dart (symbol, name, price, change, sector, marketCap, pe, pb, dividendYield)
│   │   ├── stock_filter.dart (enum Sector { all, it, banking, oilgas, pharma, auto, ... })
│   │   └── market_sector.dart (constant list of sectors)
│   ├── repositories/
│   │   └── markets_repository.dart (returns 100+ stocks)
│   └── datasources/
│       └── markets_datasource.dart (dummy list of Indian stocks)
├── pages/
│   └── markets_page.dart (with search bar at top, filter chips, sort button)
└── widgets/
    ├── stock_search_bar.dart (debounced search, 300ms delay)
    ├── stock_filter_chips.dart (horizontal scrollable sector filters)
    ├── stock_list_tile.dart (leading logo placeholder, name, price, change%)
    ├── sector_pills.dart
    └── sort_dialog.dart (bottom sheet: by price, change%, name, marketCap)
```

**Key decisions:**
- Default sort: top gainers first
- Search matches symbol and company name (case-insensitive)
- Filters: by sector, price range (future), market cap
- Stock logos: use placeholder icons or cached_network_image with placeholder images

**Performance:**
- `ListView.builder` with `itemExtent: 80`
- Debounce search input using `debounceTime` or `TextEditingController` listener with timer
- Filter operations on background isolate if list > 500 items (but 100 is fine)
- `const` list tile parts (suffix icons, dividers)

### Phase 6: Stock Details Feature (2.5 hours)

**Purpose:** Detailed stock view with interactive chart, buy/sell functionality.

**Files:**
```
lib/features/stock_details/
├── bloc/
│   ├── stock_details_bloc.dart
│   ├── stock_details_event.dart (LoadDetail, PlaceOrder, RefreshPrice)
│   └── stock_details_state.dart (Loading, Loaded, OrderPlaced, Error)
├── data/
│   ├── models/
│   │   ├── stock_detail.dart (extends Stock + dayHigh, dayLow, open, prevClose, volume, pe, pb, etc.)
│   │   ├── historical_data.dart (List<HistoricalPoint> date, open, high, low, close, volume)
│   │   ├── order_book.dart (List<Bid/Ask> with price, quantity)
│   │   └── buy_sell_request.dart (orderType, quantity, price, isBuy)
│   ├── repositories/
│   │   └── stock_details_repository.dart
│   └── datasources/
│       └── chart_datasource.dart (generates historical OHLC data)
├── pages/
│   └── stock_details_page.dart (AppBar with watchlist icon, price chart, stats grid, order panel)
└── widgets/
    ├── price_chart.dart (fl_chart LineChart with min/max/current markers, optional volume bars)
    ├── order_panel.dart (Buy/Sell tabs, quantity stepper, price selector: Market/Limit, Place Order button)
    ├── stock_stats.dart (grid: Open, High, Low, Prev Close, Volume, Market Cap, PE, PB, Dividend)
    ├── bid_ask_table.dart (5 levels each)
    └── timeframe_selector.dart (1D, 1W, 1M, 3M, 1Y, ALL - filters historical data)
```

**Key decisions:**
- Chart: Line chart showing close price with filled gradient under line
- Timeframe: default 1M (30 days), switch changes data points
- Order panel: default selected Tab (Buy), Market order fills current price automatically
- Validation: max quantity = user's buyable amount (simulated wallet balance)
- On order success: show success SnackBar, update orders list

**Performance:**
- Wrap chart in `RepaintBoundary` to avoid rebuilds on price updates
- Limit historical data: 1D = tick-by-tick (simulate 390 points), 1Y = daily (252 points)
- Cache computed min/max for chart scaling
- Use `swapAnimationDuration: Duration.zero` for instant chart updates

### Phase 7: Portfolio Feature (1.5 hours)

**Purpose:** Display user's holdings with P&L and allocation visualization.

**Files:**
```
lib/features/portfolio/
├── bloc/
│   ├── portfolio_bloc.dart
│   ├── portfolio_event.dart (LoadPortfolio)
│   └── portfolio_state.dart (Loading, Loaded)
├── data/
│   ├── models/
│   │   ├── holding.dart (stock, quantity, avgPrice, currentPrice, dayPnl, totalPnl)
│   │   ├── allocation_data.dart (label, value, color)
│   │   └── portfolio_pnl.dart (totalInvestment, currentValue, dayPnl, dayPnl%, overallPnl, overallPnl%)
│   ├── repositories/
│   │   └── portfolio_repository.dart (aggregates from watchlist + user orders)
│   └── datasources/
│       └── portfolio_datasource.dart (dummy initial holdings)
├── pages/
│   ├── portfolio_page.dart (header summary + allocation pie chart + holdings list)
│   └── holdings_page.dart (just list, click to stock details)
└── widgets/
    ├── holding_tile.dart (stock logo placeholder, name, qty, current value, P&L badge)
    ├── allocation_pie_chart.dart (fl_chart PieChart with legend)
    ├── portfolio_header.dart (big total value, percentage change card)
    └── pnl_card.dart (reusable P&L display with green/red)
```

**Key decisions:**
- P&L calculation: (currentPrice - avgPrice) * quantity
- Day P&L: (currentPrice - prevClose) * quantity (need prevClose from stock detail)
- Allocation: by sector or individual stock? Individual stock is simpler
- Initial dummy data: 3-5 holdings

**Performance:**
- `ListView.builder` for holdings
- Pie chart: max 5-8 slices, group small ones as "Others"

### Phase 8: Orders Feature (2 hours)

**Purpose:** Track and manage open/completed orders.

**Files:**
```
lib/features/orders/
├── bloc/
│   ├── orders_bloc.dart
│   ├── orders_event.dart (LoadOrders, CancelOrder, FilterByStatus)
│   └── orders_state.dart (Loading, Loaded)
├── data/
│   ├── models/
│   │   ├── order.dart (id, StockBrief, orderType, quantity, price, status, timestamp)
│   │   ├── order_type.dart (enum: market, limit, stopLoss)
│   │   ├── order_status.dart (enum: open, completed, cancelled, rejected)
│   │   └── order_history_filter.dart (enum: all, open, completed, cancelled)
│   ├── repositories/
│   │   └── orders_repository.dart (in-memory list, can add/remove)
│   └── datasources/
│       └── orders_datasource.dart (dummy orders list)
├── pages/
│   ├── orders_page.dart (tabbed: Active vs History)
│   └── order_history_page.dart (full history with filters)
└── widgets/
    ├── order_tile.dart (expandable to show order details)
    ├── order_filter_chips.dart (HorizontalChipGroup for status)
    ├── order_detail_bottom_sheet.dart (show all order fields)
    └── cancel_order_dialog.dart (confirmation alert)
```

**Key decisions:**
- Active orders tab: only open orders, can cancel
- History tab: completed/cancelled orders (read-only)
- Cancel action: removes from list, shows cancelled status (soft delete option)
- Use `showModalBottomSheet` for order details

**Performance:**
- Group orders by date (Today, Yesterday, Older) using `ListView` with sticky headers
- `AnimatedSwitcher` for order status changes

### Phase 9: Watchlist Feature (1 hour)

**Purpose:** Manage favorite stocks.

**Files:**
```
lib/features/watchlist/
├── bloc/
│   ├── watchlist_bloc.dart
│   ├── watchlist_event.dart (LoadWatchlist, AddStock, RemoveStock)
│   └── watchlist_state.dart (Loading, Loaded)
├── data/
│   ├── models/
│   │   └── watchlist_stock.dart (extends StockBrief + addedTimestamp)
│   ├── repositories/
│   │   └── watchlist_repository.dart (CRUD operations)
│   └── datasources/
│       └── watchlist_datasource.dart (SharedPreferences - store symbol list)
├── pages/
│   └── watchlist_page.dart (list of stocks, swipe to delete)
└── widgets/
    ├── watchlist_stock_tile.dart (leading icon, name, price, change%, trailing delete icon)
    └── add_to_watchlist_fab.dart (floating button: opens search dialog to add stocks)
```

**Key decisions:**
- Persist watchlist symbols in SharedPreferences
- Load stock details from Markets repository on page load
- Swipe-to-delete using `Dismissible`
- FAB on Markets page: quick add (optional)

**Performance:**
- Minimal - list is small (< 50 items typically)
- Use `Stream` for real-time price updates from market datasource

### Phase 10: Profile Feature (1.5 hours)

**Purpose:** User account and settings.

**Files:**
```
lib/features/profile/
├── bloc/
│   ├── profile_bloc.dart
│   ├── profile_event.dart (LoadProfile, UpdateProfile)
│   └── profile_state.dart (Loading, Loaded)
├── data/
│   ├── models/
│   │   ├── user_profile.dart (name, email, phone, pan, dob, profilePicUrl)
│   │   └── account_details.dart (accountNumber, balance, panVerified, kycStatus)
│   ├── repositories/
│   │   └── profile_repository.dart
│   └── datasources/
│       └── profile_datasource.dart (dummy user data)
├── pages/
│   ├── profile_page.dart (header + menu list tiles)
│   ├── settings_page.dart (notifications, theme, language)
│   ├── documents_page.dart (PAN, Aadhaar upload status)
│   └── support_page.dart (FAQ, Contact, Chat with us)
└── widgets/
    ├── profile_header.dart (circular avatar, name, edit button)
    ├── settings_tile.dart (leading icon, title, trailing switch/chevron)
    ├── account_card.dart (card with account number, balance)
    └── menu_list_tile.dart (icon + title + trailing chevron)
```

**Key decisions:**
- Profile page: vertical list of menu items (My Holdings, Orders, Watchlist, Account, Settings, Support, Logout)
- Logout: clear SharedPreferences token, navigate to Login
- Settings: simple switches for Notifications, Dark Theme toggle (already dark-only, maybe future)

**Performance:** Minimal

### Phase 11: App Shell & Main Navigation (1 hour)

**Purpose:** Bottom tab navigation with persistent state.

**Files:**
```
lib/features/app/
├── pages/
│   └── main_shell.dart
│       - Scaffold with bottomNavigationBar
│       - IndexedStack indexed by tab index (preserves state)
│       - AppBar with title based on current tab
└── widgets/
    ├── bottom_nav_bar.dart (BottomNavigationBar with 5 items: Dashboard, Markets, Portfolio, Orders, Profile)
    └── loading_overlay.dart (fullscreen loading indicator for app-level operations)
```

**Integration:**
- `main.dart` wraps MainShell with MultiBlocProvider (AuthBloc, DashboardBloc, MarketsBloc, PortfolioBloc, OrdersBloc, WatchlistBloc, ProfileBloc)
- All blocs initialized in service locator
- Watchlist and Portfolio blocs listen to OrderBloc to update holdings

**Key decisions:**
- 5 tabs: Dashboard (0), Markets (1), Portfolio (2), Orders (3), Profile (4)
- IndexedStack keeps each tab alive (Blocs stay active, scroll positions preserved)
- On tab change: AppBar title updates
- Dashboard shows marketOverview, Markets shows "Markets", etc.

### Phase 12: Bottom Navigation Integration (30 mins)

**Wire up all features:**

1. **Update all pages to use `context.read<Bloc>()` or `context.watch<Bloc>()`**
2. **Add navigation from:**

   - Dashboard → StockDetails on tile tap: `Navigator.pushNamed(context, Routes.stockDetails, arguments: stock.symbol)`
   - Markets → StockDetails
   - StockDetails → Watchlist button: dispatch `AddToWatchlistEvent`
   - Order placement → Orders tab: navigate to OrdersPage and show "Order Placed" banner
   - Portfolio holdings → StockDetails
   - Orders → StockDetails (on tile tap)

3. **Implement deep linking (optional):** route guards for auth

### Phase 13: Polish & Animations (1 hour)

**Add smooth transitions:**

- Page transitions: `PageRouteBuilder` with fade/slide (or use `animations` package)
- Shared element transitions: Hero widget on stock logo
- Micro-interactions: Ripple effects, press animations on buttons
- Loading states: Shimmer effects while data loads

**Performance tuning:**
- Run `flutter analyze` and fix warnings
- Use `DevTools` to check widget rebuild count
- Add `const` to all possible widgets
- Verify no memory leaks (streams closed in BLoC `close()`)

## Testing Strategy

**Unit Tests:**
- All BLoCs: test event → state transitions with `bloc_test`
- Repositories: test with mock datasources
- Models: test `props` and `fromJson`/`toJson`

**Widget Tests:**
- Individual widgets with mock BLoC states
- Critical user flows: Login button enables when form valid, Dashboard shows indices

**Integration Tests (time permitting):**
- Full flow: Login → Dashboard → Stock Details → Place Order → Orders tab shows order

## Critical Dependencies to Add

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.6
  equatable: ^2.0.5
  fl_chart: ^0.68.0
  cached_network_image: ^3.3.1
  shared_preferences: ^2.2.3
  animations: ^2.0.11
  get_it: ^7.6.4
  rxdart: ^0.27.7
  intl: ^0.19.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  bloc_test: ^9.1.6
  mockito: ^5.4.2
  build_runner: ^2.4.8
```

## Implementation Order Summary

1. **Phase 1:** Infrastructure (pubspec, service locator, utils, shared widgets, main.dart)
2. **Phase 2:** Base BLoC pattern
3. **Phase 3:** Authentication (foundational)
4. **Phase 4:** Dashboard (market data streaming)
5. **Phase 5:** Markets (stock browsing)
6. **Phase 6:** Stock Details (buy/sell core)
7. **Phase 7:** Portfolio
8. **Phase 8:** Orders
9. **Phase 9:** Watchlist
10. **Phase 10:** Profile
11. **Phase 11-12:** App shell & navigation integration
12. **Phase 13:** Polish, animations, performance tuning

## Verification Steps

After completing each phase:

1. **Phase 1:** `flutter pub get` succeeds, app launches to login page with dark theme
2. **Phase 3:** Login/signup works, navigates to dashboard, session persists after app restart
3. **Phase 4:** Dashboard shows indices updating every 3 seconds, quick actions tapable
4. **Phase 5:** Markets page shows 100+ stocks, search filters instantly, sort works
5. **Phase 6:** Stock details displays chart, buy order placed and appears in orders list
6. **Phase 7:** Portfolio shows holdings with correct P&L calculations
7. **Phase 8:** Orders page shows active orders, can cancel, shows history
8. **Phase 9:** Watchlist persists across app restarts, prices update
9. **Phase 10:** Profile displays user info, settings toggle works, logout returns to login
10. **Final:** All 5 tabs switch smoothly, scroll position preserved, no memory leaks

## Key Performance Targets

- **Startup time:** < 1.5 seconds to first frame
- **Scroll FPS:** 60 FPS in all lists (verify with DevTools)
- **Memory:** < 100MB typical usage, no leaks
- **BLoC rebuilds:** Minimize with `Equatable`, use `BlocSelector` for granular listening
- **Stream emissions:** Throttle market updates to ~1 Hz, debounce search input to 300ms

## Notes

- All data is dummy; no network calls required except simulated delays
- Use `Random().nextDouble()` for market price simulation with realistic bounds (±0.5% per tick)
- Stock symbols: Use real NSE symbols (RELIANCE, TCS, INFY, HDFCBANK, etc.)
- Theme colors: Use existing `AppTheme` colors (primaryColor: #6C5CE7, backgroundColor: #1A1A2E)
- Icons: Use Material icons (`Icons.trending_up`, `Icons.show_chart`, `Icons.watchlist`)
