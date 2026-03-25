
class AppUrls {
  static const baseUrl = "http://10.10.10.70:5000/api/v1";
  static const imageBase = "http://10.10.10.70:5000/";
  static String imageUrl({required String imagePath}) => "http://10.10.10.70:5000/$imagePath";
  static const socketUrl = "http://10.10.10.70:5000/";


  static const signUp = "$baseUrl/auth/signup";
  static const signIn = "$baseUrl/auth/login";
  static const verifyOtp = "$baseUrl/otp/verify-otp";
  static const resendOtp = "$baseUrl/otp/resend-otp";
  static const forgotPassword = "$baseUrl/auth/forgot-password";
  static const changePassword = "$baseUrl/auth/change-password";
  static const resetPassword = "$baseUrl/auth/reset-password";
  static const getMyProfile = "$baseUrl/users/my-profile";
  static const updateProfile = "$baseUrl/users/update-my-profile";

  static const verifyEmail = "$baseUrl/auth/verify_email";
  static const createUser = "$baseUrl/users";
  static const deleteMyAccount = "$baseUrl/users/delete-my-account";
  static const createEvent = "$baseUrl/events";
  static const notifications = "$baseUrl/notifications";
  static const myRequests = "$baseUrl/join-request/my-requests";
}
