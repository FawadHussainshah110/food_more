class PaymentConfig {
  /// Stripe Publishable Key (safe to include in client — it's public by design).
  static const String stripePublishableKey =
      'pk_test_51Tj2FK6hTaLInC4JYpMLx1VXta0csaQCbNdqh4nOnYzigglgdFrotpjr8njnqzn3bfdxpE1U7nAZt7H0hig6RX6Q00ttIEUqLS';

  /// Stripe Secret Key (loaded from compile-time definition to avoid committing to Git).
  /// Pass it via --dart-define=STRIPE_SECRET_KEY=sk_test_... when running or building. note
  static const String stripeSecretKey = String.fromEnvironment('STRIPE_SECRET_KEY', defaultValue: '');
}
