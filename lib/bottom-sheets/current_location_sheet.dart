
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/controllers/user-controllers/booking_controller.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/screens/search-place-screens/add_place_screen.dart';
import 'package:project_borla/theme/app_color.dart';
import 'package:project_borla/widgets/gradient_button.dart';

import '../screens/confirm-location-screens/confirm_location_screen.dart';
import '../screens/search-place-screens/saved_places_screen.dart';
import '../widgets/custom_text_field.dart';

class CurrentLocationSheet extends StatefulWidget {
  const CurrentLocationSheet({super.key});

  @override
  State<CurrentLocationSheet> createState() => _CurrentLocationSheetState();
}

class _CurrentLocationSheetState extends State<CurrentLocationSheet> {
  final _bookingCtrl = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
     Future.microtask(() =>  _bookingCtrl.getPlaces());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(height: 4),

            Center(
              child: Text(
                'Current location...',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 4),

            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Divider(color: AppColors.gray200, thickness: 1),
            ),

            const SizedBox(height: 8),

            // ── Search Field ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: CustomTextField(
                controller: _bookingCtrl.currentLocationController,
                hint: 'Enter the Location...',
                prefix: Image.asset('assets/images/fourth_pin.png'),
                suffix: InkWell(
                  onTap: () => _bookingCtrl.currentLocationController.clear(),
                  child: Image.asset('assets/images/cross.png'),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Saved Address Header ──────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: Row(
                children: [
                  InkWell(
                      onTap: (){
                        Get.to(()=>SavedPlacesScreen());
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/saved_icon_2.png', scale: 3.5,),

                          SizedBox(width: 8,),

                          Text('Saved Places', style: TextStyle(

                            fontSize: 18,
                            fontWeight: FontWeight.w500,


                          ),),

                        ],
                      )
                  ),

                  Spacer(),
                  InkWell(
                    onTap: () => Get.to(() => AddPlaceScreen()),
                    child: CustomContainer(
                      borderRadius: 4,
                      color: AppColors.orange300,
                      child: Icon(Icons.add, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Saved Places Chips ────────────────────────────
            Obx(() {
              if (_bookingCtrl.isGetLoading.value) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (_bookingCtrl.savedPlaces.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                  child: Text(
                    'No saved places yet',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.gray400,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: _bookingCtrl.savedPlaces.map((place) {
                      return InkWell(
                        onTap: () {
                          _bookingCtrl.currentLocationController.text = place.address;
                          _bookingCtrl.selectedPlaceLat = place.latitude;
                          _bookingCtrl.selectedPlaceLang = place.longitude;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppColors.orange300),
                          ),
                          child: Row(
                            spacing: 6,
                            children: [
                              Icon(
                                _getPlaceIcon(place.placeType),
                                color: AppColors.orange300,
                                size: 18,
                              ),
                              Text(
                                place.placeTitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }),
            SizedBox(height: 8,),
            GradientButton(
              height: 42,
              width: Get.width * 0.8,
              text: "Next",
              onPressed: () {
                Get.to(()=> ConfirmLocationScreen());
                },
            ),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  // ── Icon helper ───────────────────────────────────────────
  IconData _getPlaceIcon(String placeType) {
    switch (placeType.toLowerCase()) {
      case 'home':
        return Icons.home_outlined;
      case 'office':
        return Icons.business_outlined;
      case 'shop':
        return Icons.shopping_bag_outlined;
      case 'hotel':
        return Icons.hotel_outlined;
      default:
        return Icons.location_on_outlined;
    }
  }
}
