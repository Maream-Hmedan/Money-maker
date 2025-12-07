// ignore_for_file: non_constant_identifier_names

class ApiEndPoint {
  static String BASE_URL = "http://moneymaker-app.com/api/";
  static String REGISTER_URL = "${BASE_URL}register";
  static String LOGIN_URL = "${BASE_URL}login";
  static String PROFILE_URL = "${BASE_URL}profile";
  static String LOGOUT_URL = "${BASE_URL}logout";
  static String FORGOT_PASSWORD_URL = "${BASE_URL}forgot_password";
  static String PORTFOLIO_VALUE_URL = "${BASE_URL}get_portoflio_value";
  static String countryUrl(String langCode) => "${BASE_URL}countries/$langCode";
  static String marketUrl(String langCode) => "${BASE_URL}assets/get/$langCode";
}
