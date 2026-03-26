class Logger {
  static void debug(String message) {
    // TODO: Implement proper logging in production
    print('🔍 DEBUG: $message');
  }

  static void info(String message) {
    print('ℹ️  INFO: $message');
  }

  static void warning(String message) {
    print('⚠️  WARNING: $message');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    print('❌ ERROR: $message');
    if (error != null) print('   Error: $error');
    if (stackTrace != null) print('   StackTrace: $stackTrace');
  }
}
