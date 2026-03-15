
class AppUrls {
  static const baseUrl = "http://103.186.20.117:2000/api/v1";
  static const imageBase = "http://103.186.20.117:2000/";
  static String imageUrl({required String imagePath}) => "http://103.186.20.117:2000/$imagePath";
  static const socketUrl = "http://103.186.20.117:2005";


  static const signUp = "$baseUrl/auth/register";
  static const verifyEmail = "$baseUrl/auth/verify_email";
  static const signIn = "$baseUrl/auth/login";
  static const createUser = "$baseUrl/users";
  static const verifyOtp = "$baseUrl/otp/verify-otp";
  static const resendOtp = "$baseUrl/otp/resend-otp";
  static const forgotPassword = "$baseUrl/auth/forgot-password";
  static const changePassword = "$baseUrl/auth/change-password";
  static const resetPassword = "$baseUrl/auth/reset-password";
  static const deleteMyAccount = "$baseUrl/users/delete-my-account";
  static const getMyProfile = "$baseUrl/users/my-profile";
  static const updateProfile = "$baseUrl/users/update-my-profile";
  static const createEvent = "$baseUrl/events";
  static const notifications = "$baseUrl/notifications";
  static const myRequests = "$baseUrl/join-request/my-requests";
  static String joinEvent({eventId}) => "$baseUrl/events/join/$eventId";
  static String getUsers({page = 1, limit = 10, searchText=''}) => "$baseUrl/users?page=$page&limit=$limit&searchTerm=$searchText";
  static String getMyEvents({page, limit = 10}) => "$baseUrl/events/my-events?page=$page&limit=$limit";
  // static String getEvents({page, limit = 10, latitude, longitude, userId = '', isJoinedUser = false}) =>
  //     "$baseUrl/events?page=$page&limit=$limit&latitude=$latitude&longitude=$longitude&author=$userId&joinedUsers='${isJoinedUser?[userId]:''}'";
  static String getEvents({
    page = 1,
    limit = 10,
    latitude,
    longitude,
    String? userId,
    bool isJoinedUser = false,
  }) {
    String url = "$baseUrl/events?page=$page&limit=$limit";

    if (latitude != null) url += "&latitude=$latitude";
    if (longitude != null) url += "&longitude=$longitude";

    // Only add author if userId is provided and not joined filter
    if (userId != null && userId.isNotEmpty && !isJoinedUser) {
      url += "&author=$userId";
    }

    // Only add joinedUsers if userId is provided and isJoinedUser is true
    if (userId != null && userId.isNotEmpty && isJoinedUser) {
      url += "&joinedUsers=[$userId]";
    }

    return url;
  }
}
