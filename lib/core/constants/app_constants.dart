class AppConstants {
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String inventoryCollection = 'inventory';
  static const String stockOutCollection = 'stock_out';
  static const String notificationsCollection = 'notifications';

  // Asset Paths
  static const String splashImage = 'assets/images/splesh.png';
  static const String inventoryImage = 'assets/images/inventory.png';
  static const String inventoryListImage = 'assets/images/inventorylist.png';
  static const String reportImage = 'assets/images/report.png';
  static const String stockOutImage = 'assets/images/stockout.png';
  static const String loginImage = 'assets/images/login.png';
  static const String registerImage = 'assets/images/register.png';

  // Animation Durations
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Validation Messages
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort =
      'Password must be at least 6 characters';
  static const String nameRequired = 'Name is required';
  static const String phoneRequired = 'Phone number is required';
  static const String invalidPhone = 'Please enter a valid phone number';

  // Error Messages
  static const String somethingWentWrong = 'Something went wrong';
  static const String noInternetConnection = 'No internet connection';
  static const String tryAgain = 'Please try again';
  static const String loginFailed = 'Login failed';
  static const String registerFailed = 'Registration failed';
  static const String updateFailed = 'Update failed';
  static const String deleteFailed = 'Delete failed';

  // Login Route
  static const String loginRoute = '/login';
}
