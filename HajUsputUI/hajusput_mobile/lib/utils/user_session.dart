class UserSession {
  static int? _userId;
  static String? _username;
  static String? _password;

  static void setUser(int userId, String username, String password) {
    _userId = userId;
    _username = username;
    _password = password;
  }

  static int? get userId => _userId;
  static String? get username => _username;
  static String? get password => _password;

  static void clear() {
    _userId = null;
    _username = null;
    _password = null;
  }
}
