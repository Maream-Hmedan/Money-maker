// ignore_for_file: non_constant_identifier_names

class ApiEndPoint {
  static String BASE_URL = "http://moneymaker-app.com/api/";
  static String REGISTER_URL = "${BASE_URL}register";
  static String LOGIN_URL = "${BASE_URL}login";
  static String PROFILE_URL = "${BASE_URL}profile";
  static String LOGOUT_URL = "${BASE_URL}logout";
  static String FORGOT_PASSWORD_URL = "${BASE_URL}forgot_password";
  static String RESET_PASSWORD_URL = "${BASE_URL}update_password";
  static String PORTFOLIO_VALUE_URL = "${BASE_URL}get_portoflio_value";
  static String BALANCE_VALUE_URL = "${BASE_URL}get_balance";
  static String CONTACT_US_URL = "${BASE_URL}setting";
  static String countryUrl(String langCode) => "${BASE_URL}countries/$langCode";
  static String companyCategoriesUrl(String langCode) => "${BASE_URL}categories/$langCode";
  static String marketUrl(String langCode) => "${BASE_URL}assets/get/$langCode";
  static String marketPlaceUrl(String langCode) => "${BASE_URL}assets/get_assets_for_sale/$langCode/all";
  static String mineMarketPlaceUrl(String langCode) => "${BASE_URL}assets/get_assets_for_sale/$langCode/mine";
  static String specialOffersUrl(String langCode) => "${BASE_URL}offers/get/$langCode";
  static String privacyPolicyUrl(String langCode) => "${BASE_URL}privacy_policy/$langCode";
  static String getUserAssetsUrl(String langCode) => "${BASE_URL}assets/get_user_assets?language=$langCode";
  static String notificationsUrl(String langCode) => "${BASE_URL}get_notifications/$langCode";
  static String BUY_ASSETS_URL = "${BASE_URL}assets/buy";
  static String BUY_OFFER_URL = "${BASE_URL}offers/buy";
  static String DELETE_ACCOUNT_URL = "${BASE_URL}delete_account";
  static String EDIT_PROFILE_URL = "${BASE_URL}edit_profile";
  static String SELL_PORTFOLIO_URL = "${BASE_URL}assets/sell";
  static String CANCEL_PORTFOLIO_URL = "${BASE_URL}assets/cancel_offer";
  static String ADD_COMPANY_URL = "${BASE_URL}add_company";
  static String USER_COMPANY_URL = "${BASE_URL}user/companies";
  static String TOP_LEADERBOARD_URL = "${BASE_URL}leaderboard";
  static String TOP_UP_BALANCE_URL = "${BASE_URL}payment/top_up";
  static String GET_ORDERS_URL = "${BASE_URL}get_orders";
  static String GET_TRANSACTION_URL = "${BASE_URL}get_transactions";
}
