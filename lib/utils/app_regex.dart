class AppRegex {
  // Email Validation Pattern
  static final RegExp emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  // Password Validation (At least 6 characters)
  static final RegExp passwordMinLength = RegExp(r'^.{6,}$');

  // No Spaces Allowed (Useful for email, password, usernames)
  static final RegExp noSpaces = RegExp(r'\s');

  // Only Digits (Useful for phone numbers, OTPs, etc.)
  static final RegExp onlyDigits = RegExp(r'^\d+$');
}
