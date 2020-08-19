class ValidatorHelper {
  static String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please type an email';
    }
    return "";
  }

  static String validatePassword(String pass) {
    if (pass.isEmpty) {
      return 'Please provide a password';
    } else if (pass.length < 6) {
      return 'Your password needs to be atleast 6 characters';
    }
    return "";
  }

  static String isPasswordMatch(String pass, String confirm) {
    if (pass != confirm) {
      return 'Password does not match';
    }
    return "";
  }
}
