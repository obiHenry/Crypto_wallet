class Validators {
  static String email(String value) {
    if (value.isEmpty) {
      return 'Please enter a valid email address';
    }
    if (!value.contains('@')) {
      return 'Email is invalid, must contain @';
    }
    if (!value.contains('.')) {
      return 'Email is invalid, must contain .';
    }
    return null;
  }

  static String password(String value) {
    if (value.isEmpty) {
      return 'Please enter your Password';
    }
    if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }
    return null;
  }

  static String confirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }
    // if (value != password(value)) {
    //   return 'confirm password must match password';
    // }
    return null;
  }

  static String alnum(String value, String type) {
    if (value.isEmpty) {
      return '$type is required';
    }
    if (value.length < 3) {
      return 'Enter a valid ${type.toLowerCase()}';
    }
    return null;
  }

  static String valInt(String value, String type) {
    if (value.isEmpty) {
      return '$type is required';
    }
    if (num.tryParse(value) == null) {
      return '$type cannot contain alphabets or special characters';
    }
    return null;
  }

  static String phone(String value) {
    if (value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    if (num.tryParse(value) == null) {
      return 'Phone number cannot contain alphabets or special characters';
    }
    return null;
  }
}
