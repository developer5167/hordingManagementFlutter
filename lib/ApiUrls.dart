
class ApiUrl {
  static String baseUrl = 'http://192.168.15.224:4000/';

  static String loginUrl() => '${baseUrl}login';

  static String sendOtp() => '${baseUrl}sendOtp';

  static String verifyOtp() => '${baseUrl}verifyOtp';

  static String createUser() => '${baseUrl}createUser';

  static String changeLoginPassword() => '${baseUrl}changeLoginPassword';

  static String getDeviceIds() => '${baseUrl}getDeviceIds';

  static String upload() => '${baseUrl}upload';

  static String saveAdData() => '${baseUrl}saveAdData';

  static String fetchUserActiveAds(String userId) => '${baseUrl}fetchUserActiveAds?user_id=$userId';

  static String fetchUserPausedAds(String userId) => '${baseUrl}fetchUserPausedAds?user_id=$userId';

  static String fetchUserInReviewAds(String userId) => '${baseUrl}fetchUserInReviewAds?user_id=$userId';
  static String fetchUserExpiredAds(String userId) => '${baseUrl}fetchUserExpiredAds?user_id=$userId';
  static String getStatics(String adId) => '${baseUrl}getStatics?ad_id=$adId';
}
