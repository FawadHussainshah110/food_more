import 'dart:developer';

import 'package:get/get.dart';

class Validators {
  static String? emptyValidator(String? v) {
    if (v == null || v == '') {
      return 'required_field'.tr;
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'phone_number_required'.tr;
    } else if (v.length < 8) {
      return 'invalid_phone_number'.tr;
    } else if (v.length > 15) {
      return 'phone_number_length'.tr;
    } else if (!RegExp(r"^\d+$").hasMatch(v)) {
      return 'invalid_phone_format'.tr;
    }
    return null;
  }

  static String? emailValidator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'email_required'.tr;
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(v)) {
      return 'invalid_email_format'.tr;
    }
    return null;
  }

  static String? passwordValidator(String? v) {
    if (v!.trim().isEmpty || v.length < 6) {
      return 'invalid_password'.tr;
    }
    return null;
  }

  static String? confirmPasswordValidator(String? v, String? password) {
    if (v == null || v.isEmpty) {
      return 'confirm_password_required'.tr;
    }
    if (v != password) {
      return 'passwords_do_not_match'.tr;
    }
    return null;
  }

  static String? dateOfBirthValidator(String? value) {
    if (value == null || value.isEmpty) return "Date of birth is required";

    final RegExp regex = RegExp(r'^(\d{1,2})\/(\d{1,2})\/(\d{4})$');

    if (!regex.hasMatch(value)) return "Invalid format (MM/DD/YYYY)";

    try {
      final parts = value.split('/');
      int month = int.parse(parts[0]);
      int day = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      log("Month: $month, Day: $day, Year: $year");

      if (month < 1 || month > 12) return "Invalid month";
      if (day < 1 || day > 31) return "Invalid day";

      final dob = DateTime(year, month, day);

      if (dob.month != month || dob.day != day || dob.year != year) {
        return "Invalid date";
      }

      final now = DateTime.now();
      if (dob.isAfter(now)) {
        return "Date of birth cannot be in the future";
      }
    } catch (_) {
      return "Invalid date";
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Amount';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter company address';
    }
    if (value.length < 5) {
      return 'Address must be at least 5 characters long';
    }
    return null;
  }
}
