
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
  static const createUser = "$baseUrl/auth/signup";
  static const deleteMyAccount = "$baseUrl/users/delete-my-account";
  static const createEvent = "$baseUrl/events";
  static const myRequests = "$baseUrl/join-request/my-requests";
  static const aboutUs = "$baseUrl/content-pages/about-us";
  static const termsCondition = "$baseUrl/content-pages/terms-and-conditions";
  static const privacyPolicy = "$baseUrl/content-pages/privacy-policy";

  static const createBookings = "$baseUrl/bookings";
  static const newPlaces = "$baseUrl/saved-places";

  static const toggleMyStatus = "$baseUrl/users/toggle-my-status";
  static const updateMyLocation = "$baseUrl/users/update-my-location";
  static const stations = "$baseUrl/stations";
  static const getChatList = "$baseUrl/messages/my-chats";
  static const notifications = "$baseUrl/notifications/my";
  static const readNotifications = "$baseUrl/notifications/read-all";
  static const getSupportChatID = "$baseUrl/messages/support/my-chats";
  static const sendSupportChat = "$baseUrl/messages/support";

  static String markNotificationByID({id}) => "$baseUrl/notifications/$id/read";
  static String getSupportMessages({String chatId = ''}) => "$baseUrl/messages/support/my-chats/$chatId/messages";

  static String getMessages({required String bookingId}) => "$baseUrl/messages/booking/$bookingId";
  static String sendMessages({required String bookingId}) => "$baseUrl/messages/booking/$bookingId?";

  static String availableBookings({bool isPopulateUser = true}) => "$baseUrl/bookings/available?populateUser=$isPopulateUser";
  static String updatePlace({required String id}) => "$baseUrl/saved-places/$id";
  static String getAcceptedBookings({required String status}) => "$baseUrl/bookings/rider-bookings?status=$status";
  static String getMyBookings({required String status}) => "$baseUrl/bookings/my-bookings?status=$status";
  static String acceptBooking({required String id}) => "$baseUrl/bookings/$id/accept";
  static String declineBooking({required String id}) => "$baseUrl/bookings/$id/decline";
  static String arriveAtPickup({required String id}) => "$baseUrl/bookings/$id/arrive-pickup";
  static String paymentCollection({required String id}) => "$baseUrl/bookings/$id/payment-collected";
  static String headingStation({required String id}) => "$baseUrl/bookings/$id/heading-to-station";
  static String bookingCompleted({required String id}) => "$baseUrl/bookings/$id/completed";
  static String getSingleBooking({required String id}) => "$baseUrl/bookings/$id";
  static String updateBookingStatus({required String id}) => "$baseUrl/bookings/$id/status";
}

class SocketEvents{
  static String joinChatEmit = "chat:join";
  static String newMessageOn = "message:new";
  static String chatTypingOn = "chat:typing";
  static String chatTypingEmit = "chat:typing";
  static String leaveChatRoomEmit = "chat:leave";
}