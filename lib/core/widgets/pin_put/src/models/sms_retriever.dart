part of '../pinput.dart';

abstract class SmsRetriever {
  bool get listenForMultipleSms;
  Future<String?> getSmsCode();
  Future<void> dispose();
}
