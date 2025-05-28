extension ExtString on String {
  bool get isEmailValid {
    final emailRegEx = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegEx.hasMatch(this);
  }

  bool get isPasswordValid {
    final passwordRegEx =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
    return passwordRegEx.hasMatch(this);
  }

  String get authErrorTranslate {
    switch (this) {
      case "Invalid email or password":
        return "ایمیل یا رمز عبور اشتباه است";
      case "User with this email already exists":
        return "کاربر با این ایمیل وجود دارد";
      default:
        return "خطای ناشناخته‌ای رخ داده است";
    }
  }
}
