import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../../../../core/config/payment_config.dart';
import 'payment_repo_interface.dart';

class PaymentRepo implements PaymentRepoInterface {
  final http.Client httpClient;

  PaymentRepo({required this.httpClient});

  @override
  Future<bool> processStripePayment({
    required double amount,
    required String currency,
  }) async {
    final secretKey = PaymentConfig.stripeSecretKey;
    if (secretKey.isEmpty) {
      throw Exception('Stripe Secret Key is not configured. Please run/build the app with --dart-define=STRIPE_SECRET_KEY=sk_test_...');
    }

    final amountInCents = (amount * 100).toInt().toString();

    // 1. Create Payment Intent
    final response = await httpClient.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': amountInCents,
        'currency': currency,
        'payment_method_types[]': 'card',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error']?['message'] ?? 'Failed to create payment intent';
      throw Exception(errorMessage);
    }

    final paymentIntent = jsonDecode(response.body);
    final String? clientSecret = paymentIntent['client_secret'];

    if (clientSecret == null) {
      throw Exception('Failed to obtain client secret from Stripe.');
    }

    // 2. Initialize Payment Sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'FoodMore App',
        style: ThemeMode.system == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
      ),
    );

    // 3. Present Payment Sheet
    await Stripe.instance.presentPaymentSheet();

    return true;
  }
}
