const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");

// Secret key is stored securely in Firebase — never in source code or APK
const stripeSecretKey = defineSecret("STRIPE_SECRET_KEY");

exports.createPaymentIntent = onRequest(
  { secrets: [stripeSecretKey], cors: true },
  async (req, res) => {
    // Only allow POST requests
    if (req.method !== "POST") {
      res.status(405).json({ error: "Method not allowed" });
      return;
    }

    try {
      const { amount, currency } = req.body;

      // Validate input
      if (!amount || !currency) {
        res.status(400).json({ error: "Missing required fields: amount, currency" });
        return;
      }

      const amountInt = parseInt(amount, 10);
      if (isNaN(amountInt) || amountInt <= 0) {
        res.status(400).json({ error: "Invalid amount" });
        return;
      }

      // Initialize Stripe with the secret from Firebase Secrets
      const stripe = require("stripe")(stripeSecretKey.value());

      // Create a PaymentIntent
      const paymentIntent = await stripe.paymentIntents.create({
        amount: amountInt,
        currency: currency,
        payment_method_types: ["card"],
      });

      // Return only the client_secret to the Flutter app
      res.status(200).json({
        client_secret: paymentIntent.client_secret,
      });
    } catch (error) {
      console.error("Stripe error:", error.message);
      res.status(500).json({ error: error.message });
    }
  }
);
