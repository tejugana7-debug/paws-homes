class Validators {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your full name';
    }

    final name = value.trim();

    if (name.length < 3) {
      return 'Name must contain at least 3 characters';
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      return 'Use letters only';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your phone number';
    }

    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value.trim())) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email';
    }

    if (!RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$').hasMatch(value.trim())) {
      return 'Enter a valid email, like name@example.com';
    }

    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().length < 10) {
      return 'Enter your full address';
    }

    return null;
  }

  static String? validateReason(String? value) {
    if (value == null || value.trim().length < 20) {
      return 'Tell us a little more (at least 20 characters)';
    }

    return null;
  }
}
