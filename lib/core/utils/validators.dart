class Validators {
  /// Checks if a field is not empty
  static String? requiredField(String? value, {String fieldName = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Validates email format

  static String? email(String? value) {
    if (value == null || value.isEmpty) return "Email is required";

    final regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|in|co|us|uk)$',
      caseSensitive: false,
    );

    if (!regex.hasMatch(value)) {
      return "Enter a valid email address";
    }

    return null;
  }

  static bool checkEmail(String? value) {
    final regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|org|net|edu|gov|io|in|co|us|uk)$',
      caseSensitive: false,
    );

    return regex.hasMatch(value ?? "");
  }

  static bool validName(String value) {
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    return nameRegExp.hasMatch(value);
  }

  /// Validates password with minimum length
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < minLength) {
      return "Password must be at least $minLength characters long";
    }
    return null;
  }

  static bool isStrongPassword(String password) {
    final strongRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return strongRegex.hasMatch(password);
  }

  /// Validates if confirmation matches original password
  static String? confirmPassword(String? value, String? original) {
    if (value != original) return "Passwords didn't match. Please try again";
    return null;
  }

  /// Validates phone number (basic international format)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return "Phone number is required";
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!regex.hasMatch(value)) return "Enter a valid phone number";
    return null;
  }

  /// Validates username (letters, numbers, underscores, min 3 chars)
  static String? username(String? value, {int minLength = 3}) {
    if (value == null || value.isEmpty) return "Username is required";
    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(value)) {
      return "Username can only contain letters, numbers, and underscores";
    }
    if (value.length < minLength) {
      return "Username must be at least $minLength characters long";
    }
    return null;
  }

  /// Checks if input is a valid number
  static String? number(String? value, {bool allowDecimal = false}) {
    if (value == null || value.isEmpty) return "This field is required";
    final regex = allowDecimal ? RegExp(r'^\d+(\.\d+)?$') : RegExp(r'^\d+$');
    if (!regex.hasMatch(value)) return "Enter a valid number";
    return null;
  }

  /// Validates min/max length for a field
  static String? length(
    String? value, {
    int? min,
    int? max,
    String fieldName = "Field",
  }) {
    if (value == null || value.isEmpty) return "$fieldName is required";
    if (min != null && value.length < min) {
      return "$fieldName must be at least $min characters long";
    }
    if (max != null && value.length > max) {
      return "$fieldName must be at most $max characters long";
    }
    return null;
  }

  /// Validates if input is a valid URL
  static String? url(String? value) {
    if (value == null || value.isEmpty) return "URL is required";
    final regex = RegExp(
      r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-.,@?^=%&:/~+#]*)?$',
    );
    if (!regex.hasMatch(value)) return "Enter a valid URL";
    return null;
  }

  /// Validates if input is a valid credit card number (basic Luhn check)
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) return "Credit card number is required";
    final regex = RegExp(r'^[0-9]{13,19}$');
    if (!regex.hasMatch(value)) return "Enter a valid credit card number";

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;
    for (int i = value.length - 1; i >= 0; i--) {
      int n = int.parse(value[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    if (sum % 10 != 0) return "Invalid credit card number";

    return null;
  }
}
