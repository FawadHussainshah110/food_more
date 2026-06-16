abstract class PaymentRepoInterface {
  /// Processes a payment through Stripe for the given [amount] and [currency].
  /// Returns `true` if the payment succeeded, or throws/returns `false` if cancelled/failed.
  Future<bool> processStripePayment({
    required double amount,
    required String currency,
  });
}
