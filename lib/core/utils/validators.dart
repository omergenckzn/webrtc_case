import 'package:dating_app/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validatePassword(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Password field cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? validateEmail(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Email field cannot be empty';
    } else if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validateDate(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Date field cannot be empty';
    }
    return null;
  }

  static String? validateName(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  /* static String? validateUsername(String? value, S locale) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

    if (value == null || value.isEmpty) {
      return locale.usernameRequired;
    }

    if (!usernameRegex.hasMatch(value)) {
      return locale.usernameInvalid;
    }

    if (value.startsWith('_') || value.endsWith('_')) {
      return locale.usernameNoUnderscoreStartEnd;
    }

    if (value.contains('__')) {
      return locale.usernameNoConsecutiveUnderscores;
    }

    return null;
  } */

  static String? validateAddressHeadline(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Address headline cannot be empty';
    }
    return null;
  }

  static String? validateAddressDetail(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Address detail cannot be empty';
    }
    return null;
  }

  static String? validateSurname(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Surname field cannot be empty';
    }
    return null;
  }

  static String? validatePhone(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Phone field cannot be empty';
    }
    return null;
  }

  static String? validatePasswordMatch(
      String? value, String? password, S locale) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateCardHolderName(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Card holder name cannot be empty';
    }
    return null;
  }

  static String? validateCardNumber(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'Card number cannot be empty';
    } else if (value.replaceAll(RegExp(r'\D'), '').length != 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  static String? validateCVV(String? value, S locale) {
    if (value == null || value.isEmpty) {
      return 'CVV cannot be empty';
    } else if (value.length != 3) {
      return 'CVV must be 3 digits';
    }
    return null;
  }

  static String? validateMonth(int? value, S locale) {
    if (value == null) {
      return 'Month cannot be empty';
    }
    return null;
  }

  static String? validateYear(int? value, S locale) {
    if (value == null) {
      return 'Year cannot be empty';
    }
    return null;
  }
}
