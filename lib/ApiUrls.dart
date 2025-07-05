class ApiUrl {
  static String baseUrl = 'http://192.168.1.39:4000/';

  static String loginUrl() => '${baseUrl}login';

  static String sendOtp() => '${baseUrl}sendOtp';

  static String verifyOtp() => '${baseUrl}verifyOtp';

  static String createUser() => '${baseUrl}createUser';

  static String changeLoginPassword() => '${baseUrl}changeLoginPassword';

  static String getDeviceIds() => '${baseUrl}getDeviceIds';

  static String upload() => '${baseUrl}upload';

  static String saveAdData() => '${baseUrl}saveAdData';

  static String saveCompanyAdData() => '${baseUrl}saveCompanyAdData';

  static String fetchUserActiveAds(String userId) => '${baseUrl}fetchUserActiveAds?user_id=$userId';

  static String fetchUserPausedAds(String userId) => '${baseUrl}fetchUserPausedAds?user_id=$userId';

  static String fetchUserInReviewAds(String userId) => '${baseUrl}fetchUserInReviewAds?user_id=$userId';

  static String fetchUserExpiredAds(String userId) => '${baseUrl}fetchUserExpiredAds?user_id=$userId';

  static String getStatics(String adId) => '${baseUrl}getStatics?ad_id=$adId';

  static String turnOfClientAds(String deviceId, bool isEnabled) => '${baseUrl}turnOfClientAds?device_id=$deviceId&isEnabled=$isEnabled';
  static String turnOffAllAds(String deviceId, bool isEnabled) => '${baseUrl}turnOffAllAds?device_id=$deviceId&isEnabled=$isEnabled';

  static String getAllSettingsEvent(String deviceId) => '${baseUrl}getAllSettingsEvent?device_id=$deviceId';
}
