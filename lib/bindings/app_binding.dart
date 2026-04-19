import 'package:get/get.dart';
import 'package:project_borla/controllers/authController/auth_controller.dart';
import 'package:project_borla/controllers/date_time_picker_controller.dart';
import 'package:project_borla/controllers/mapController/user_map_controller.dart';
import 'package:project_borla/controllers/profileController/profile_controller.dart';
import 'package:project_borla/controllers/settingsController/settings_controller.dart';
import 'package:project_borla/controllers/user-controllers/alert-dialog-controllers/booking_requested_controller.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/choose_ride_sheet_controllers.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/driver_info_sheet_controllers.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/rating_controller.dart';
import 'package:project_borla/controllers/user-controllers/bottom-sheet-controllers/rider_review_sheet_controllers.dart';
import 'package:project_borla/controllers/user-controllers/cancel_ride_controller.dart';
import 'package:project_borla/controllers/user-controllers/user_address_screens_controllers.dart';
import 'package:project_borla/controllers/user-controllers/user_change_pass_controllers.dart';
import 'package:project_borla/controllers/user-controllers/user_edit_profile_controllers.dart';
import 'package:project_borla/controllers/user-controllers/user_outgoing_call_controller.dart';
import 'package:project_borla/controllers/user-controllers/user_profile_address_controllers.dart';
import 'package:project_borla/controllers/user-controllers/user_register_controller.dart';
import 'package:project_borla/controllers/user-controllers/payment_controller.dart';
import 'package:project_borla/role/commonScreens/chat/innerController/chat_controller.dart';
import 'package:project_borla/role/components/navBar/controller/nav_bar_controller.dart';
import 'package:project_borla/role/garbageCollector/activity/controller/activity_controller.dart';
import 'package:project_borla/role/garbageCollector/call/controller/call_controller.dart';
import 'package:project_borla/role/garbageCollector/earnings/controller/earnings_controller.dart';
import 'package:project_borla/role/garbageCollector/home/controller/driver_home_controller.dart';
import 'package:project_borla/screens/activity-screens/activity-controller/user_activity_controller.dart';
import 'package:project_borla/screens/home-screens/user-home-screens/user-controller/user_home_controller.dart';
import 'package:project_borla/screens/home-screens/user_nav_bar.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';
import 'package:project_borla/screens/waste-screens/waste-controllers/waste_category_controller.dart';

import '../controllers/mapController/driver_map_controller.dart';
import '../controllers/notificationController/notification_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // ── Auth & Settings ───────────────────────────────────────────
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);

    // ── Profile ───────────────────────────────────────────────────
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<UserProfileAddressControllers>(() => UserProfileAddressControllers(), fenix: true);
    Get.lazyPut<UserEditProfileControllers>(() => UserEditProfileControllers(), fenix: true);
    Get.lazyPut<UserChangePassControllers>(() => UserChangePassControllers(), fenix: true);
    Get.lazyPut<UserAddressScreensControllers>(() => UserAddressScreensControllers(), fenix: true);

    // ── User Navigation & Home ────────────────────────────────────
    Get.lazyPut<UserNavBarController>(() => UserNavBarController(), fenix: true);

    // ── Map ───────────────────────────────────────────────────────
    Get.lazyPut<DriverMapController>(() => DriverMapController(), fenix: true);
    Get.lazyPut<UserMapController>(() => UserMapController(), fenix: true);

    // ── Booking & Ride ────────────────────────────────────────────
    Get.lazyPut<BookingController>(() => BookingController(), fenix: true);
    Get.lazyPut<UserHomeController>(() => UserHomeController(), fenix: true);
    Get.lazyPut<BookingRequestedController>(() => BookingRequestedController(), fenix: true);
    Get.lazyPut<CancelRideController>(() => CancelRideController(), fenix: true);
    Get.lazyPut<DateTimePickerController>(() => DateTimePickerController(), fenix: true);

    // ── Bottom Sheets ─────────────────────────────────────────────
    Get.lazyPut<ChooseRideSheetControllers>(() => ChooseRideSheetControllers(), fenix: true);
    Get.lazyPut<DriverInfoSheetControllers>(() => DriverInfoSheetControllers(), fenix: true);
    Get.lazyPut<RatingController>(() => RatingController(), fenix: true);
    Get.lazyPut<RiderReviewSheetControllers>(() => RiderReviewSheetControllers(), fenix: true);

    // ── Search & Places ───────────────────────────────────────────
    Get.lazyPut<LocationSearchController>(() => LocationSearchController(), fenix: true);
    Get.lazyPut<LocationSearchTwoController>(() => LocationSearchTwoController(), fenix: true);
    Get.lazyPut<SavedPlaceController>(() => SavedPlaceController(), fenix: true);
    Get.lazyPut<AddPlaceController>(() => AddPlaceController(), fenix: true);
    Get.lazyPut<EditPlaceController>(() => EditPlaceController(), fenix: true);

    // ── Notification ─────────────────────────────────────────────────────
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);

    // ── Waste ─────────────────────────────────────────────────────
    Get.lazyPut<WasteCategoryController>(() => WasteCategoryController(), fenix: true);

    // ── User Register & Auth ──────────────────────────────────────
    Get.lazyPut<UserRegisterController>(() => UserRegisterController(), fenix: true);

    // ── Call ──────────────────────────────────────────────────────
    Get.lazyPut<UserOutgoingCallController>(() => UserOutgoingCallController(), fenix: true);

    // ── Chat ──────────────────────────────────────────────────────
    Get.lazyPut<ChatController>(() => ChatController(), fenix: true);

    // ── User Activity ─────────────────────────────────────────────
    Get.lazyPut<UserActivityController>(() => UserActivityController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);

    // ── Garbage Collector Role ────────────────────────────────────
    Get.lazyPut<MainNavController>(() => MainNavController(), fenix: true);
    Get.lazyPut<DriverHomeController>(() => DriverHomeController(), fenix: true);
    Get.lazyPut<ActivityController>(() => ActivityController(), fenix: true);
    Get.lazyPut<EarningsController>(() => EarningsController(), fenix: true);
    Get.lazyPut<CallController>(() => CallController(), fenix: true);
  }
}
