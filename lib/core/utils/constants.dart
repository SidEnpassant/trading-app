import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Trading App';
  static const int marketUpdateIntervalMs = 3000;
  static const int searchDebounceMs = 300;
  static const int maxQuantity = 10000;
  static const double walletBalance = 100000.0; // ₹1,00,000 dummy balance

  // Mock data seeds
  static const List<String> nseSymbols = [
    'RELIANCE',
    'TCS',
    'INFY',
    'HDFCBANK',
    'ICICIBANK',
    'SBIN',
    'BHARTIARTL',
    'WIPRO',
    'AXISBANK',
    'KOTAKBANK',
    'ITC',
    'SUNPHARMA',
    'BAJAJFINSV',
    'HINDUNILVR',
    'MARUTI',
    'ASIANPAINT',
    'TITAN',
    'ULTRACEMCO',
    'TATAMOTORS',
    'BAJAJ-AUTO',
    'NESTLEIND',
    'POWERGRID',
    'NTPC',
    'ADANIENT',
    'ADANIPORTS',
    'ADANIGREEN',
    'DMART',
    'ZOMATO',
  ];

  static const List<String> sectors = [
    'All',
    'IT',
    'Banking',
    'Pharma',
    'Auto',
    'FMCG',
    'Oil & Gas',
    'Metals',
    'Realty',
    'Finance',
    'Construction',
    'Telecom',
  ];
}

class ApiEndpoints {
  static const String baseUrl = 'https://api.mocktrading.com';
  static const String login = '$baseUrl/auth/login';
  static const String signup = '$baseUrl/auth/signup';
  static const String dashboard = '$baseUrl/dashboard';
  static const String markets = '$baseUrl/markets/stocks';
  static const String stockDetails = '$baseUrl/stocks';
  static const String orders = '$baseUrl/orders';
  static const String portfolio = '$baseUrl/portfolio';
  static const String watchlist = '$baseUrl/watchlist';
  static const String profile = '$baseUrl/profile';
}
