class Validator {
  String? validateMail(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePass(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter your password';
    }
    if (input.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
