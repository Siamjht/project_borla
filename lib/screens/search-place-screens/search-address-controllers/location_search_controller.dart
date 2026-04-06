import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_borla/controllers/mapController/user_map_controller.dart';
import 'package:project_borla/map_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/user-controllers/booking_controller.dart';
import '../../../models/userModels/searchAddressModels/place_suggestion_model.dart';
import '../../../services/api_service.dart';
import '../../confirm-location-screens/confirm_location_screen.dart';

class LocationSearchController extends GetxController{

  //TextEditingController addressController = TextEditingController();

  final RxBool isClear = false.obs ;

  void clearAll () {

    isClear.value = true;

  }

}

class SavedPlaceController extends GetxController {

  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


}

class EditPlaceController extends GetxController{


  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

}

class AddPlaceController extends GetxController{

  RxString selectedPlace = "".obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController placeNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();


}

class LocationSearchTwoController extends GetxController {
  final TextEditingController addressController = TextEditingController();

  final RxList<PlaceSuggestionModel> suggestions = <PlaceSuggestionModel>[].obs;
  final RxList<RecentSearchModel> recentSearches = <RecentSearchModel>[].obs;
  final RxBool isSearching = false.obs;
  final RxBool isLoadingSuggestions = false.obs;

  static const String _recentKey = 'recent_searches';
  static const int _maxRecent = 10;
  static const String _apiKey = MapApiKey.mapKey;

  Timer? _debouncer;

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
    addressController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = addressController.text.trim();

    if (query.isEmpty) {
      isSearching.value = false;
      suggestions.clear();
      _debouncer?.cancel();
      return;
    }

    isSearching.value = true;
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      _fetchSuggestions(query);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    isLoadingSuggestions.value = true;
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=${Uri.encodeComponent(query)}'
          '&key=$_apiKey'
          '&language=en';

      final response = await ApiService.get(url);

      if (response.statusCode == 200) {
        final predictions = response.body['predictions'] as List;
        suggestions.value = predictions
            .map((e) => PlaceSuggestionModel.fromJson(e))
            .toList();
      }
    } finally {
      isLoadingSuggestions.value = false;
    }
  }

  Future<void> selectSuggestion(PlaceSuggestionModel suggestion) async {
    // Fetch lat/lng from place details
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json'
        '?place_id=${suggestion.placeId}'
        '&fields=geometry'
        '&key=$_apiKey';

    final response = await ApiService.get(url);

    double lat = 0.0;
    double lng = 0.0;

    if (response.statusCode == 200) {
      final location = response.body['result']['geometry']['location'];
      lat = location['lat'];
      lng = location['lng'];
      BookingController.instance.selectedPlaceLat = lat;
      BookingController.instance.selectedPlaceLang = lng;
      BookingController.instance.currentLocationController.text = suggestion.address;
      final latLng = LatLng(lat, lng);
      await UserMapController.instance.placeUserMarker(latLng);
      UserMapController.instance.pendingCameraTarget = latLng;
    }

    final recent = RecentSearchModel(
      title: suggestion.title,
      address: suggestion.address,
      latitude: lat,
      longitude: lng,
    );

    await _saveRecentSearch(recent);
    suggestions.clear();
    isSearching.value = false;

    Get.to(() => ConfirmLocationScreen());
  }

  Future<void> selectRecent(RecentSearchModel recent) async {
    addressController.text = recent.title;
    final latLng = LatLng(recent.latitude, recent.longitude);
    await UserMapController.instance.placeUserMarker(latLng);
    UserMapController.instance.pendingCameraTarget = latLng;
    Get.to(() => ConfirmLocationScreen());
  }

  // ── Local Storage ──────────────────────────────────────────

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList(_recentKey) ?? [];
    recentSearches.value = stored
        .map((e) => RecentSearchModel.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> _saveRecentSearch(RecentSearchModel recent) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove duplicate if exists
    recentSearches.removeWhere((r) => r.title == recent.title);

    // Add to front
    recentSearches.insert(0, recent);

    // Keep only last 10
    if (recentSearches.length > _maxRecent) {
      recentSearches.value = recentSearches.take(_maxRecent).toList();
    }

    final encoded = recentSearches.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_recentKey, encoded);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentKey);
    recentSearches.clear();
  }

  // @override
  // void onClose() {
  //   _debouncer?.cancel();
  //   addressController.removeListener(_onSearchChanged);
  //   addressController.dispose();
  //   super.onClose();
  // }
}