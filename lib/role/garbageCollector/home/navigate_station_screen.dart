

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/models/riderModels/bookingModels/rider_booking_model.dart';
import '../../../controllers/mapController/driver_map_controller.dart';
import '../../../gen/custom_assets/assets.gen.dart';
import '../../../models/riderModels/wasteStationModel/waste_station_model.dart';
import '../../../theme/app_color.dart';
import '../../components/button/common_button.dart';
import '../../components/commonBackButton/common_back_button.dart';
import '../../components/customSnackbar/custom_snackbar.dart';
import '../../components/custom_container.dart';
import '../../components/text/common_text.dart';
import '../activity/controller/activity_controller.dart';
import '../map/driver_common_map.dart';
import 'controller/driver_home_controller.dart';
import 'innerWidget/arrive_at_station_dialog.dart';

class NavigateStationScreen extends StatefulWidget {
  RiderBookingModel booking;
  NavigateStationScreen({super.key, required this.booking,});

  @override
  State<NavigateStationScreen> createState() => _NavigateStationScreenState();
}

class _NavigateStationScreenState extends State<NavigateStationScreen> {
  final DriverHomeController _homeCtrl = Get.find<DriverHomeController>();
  final DriverMapController _mapCtrl = Get.find<DriverMapController>();
  StationModel? station;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // ✅ fetch stations then draw route to nearest one
      await _homeCtrl.getStations();
      _navigateToNearestStation();
      final station = _nearestStation;
      if(station != null){
        if(widget.booking.status == "completed"){
          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => ArriveAtStationDialog(station: station, booking: widget.booking,),
            );
          }
        }
      }
    });
  }

  void _navigateToNearestStation() {
    if (_homeCtrl.stations.isEmpty) return;

    // ✅ explicit type on reduce
    StationModel nearest = _homeCtrl.stations.first;
    double nearestDistance = _homeCtrl.calculateDistanceToStation(nearest);

    for (final station in _homeCtrl.stations) {
      final distance = _homeCtrl.calculateDistanceToStation(station);
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearest = station;
      }
    }

    _mapCtrl.startToStationPhase(nearest.latLng);
  }

  StationModel? get _nearestStation {
    if (_homeCtrl.stations.isEmpty) return null;

    // ✅ same explicit approach
    StationModel nearest = _homeCtrl.stations.first;
    double nearestDistance = _homeCtrl.calculateDistanceToStation(nearest);

    for (final station in _homeCtrl.stations) {
      final distance = _homeCtrl.calculateDistanceToStation(station);
      if (distance < nearestDistance) {
        nearestDistance = distance;
        nearest = station;
      }
    }

    return nearest;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          Positioned.fill(child: DriverCommonMap()),

          Positioned(
            top: 60,
            left: 20,
            child: CommonBackButton(),
          ),

          // ── Station Address Card ────────────────────────
          Positioned(
            bottom: 120,
            left: 30,
            right: 30,
            child: Obx(() {
              if (_homeCtrl.isStationsLoading.value) {
                return CustomContainer(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 16),
                  borderRadius: 8,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              station = _nearestStation;

              return CustomContainer(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 16),
                borderRadius: 8,
                child: Row(
                  children: [
                    CustomContainer(
                      padding: const EdgeInsets.all(8),
                      borderRadius: 100,
                      color: AppColors.green50,
                      child: Center(
                        child: Assets.icons.locationPointer
                            .image(height: 20, width: 20),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonText(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w400,
                            text: 'Recommended Route',
                            color: AppColors.green500,
                          ),
                          CommonText(
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            // ✅ real station name and distance
                            text: station != null
                                ? '${station?.name} • ${_homeCtrl.calculateDistanceToStation(station!).toStringAsFixed(1)} km'
                                : '—',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),

          // ── Navigate Button ─────────────────────────────
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Obx(() => CommonButton(
              isLoading: ActivityController.instance.isHeadingToStationLoading.value,
              onTap: () async {
                final station = _nearestStation;
                if(station != null){
                  if(widget.booking.status != "completed"){
                    await ActivityController.instance.headingToStation(bookingId: widget.booking.id, stationId: station.id);
                    if (mounted) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) => ArriveAtStationDialog(station: station, booking: widget.booking,),
                      );
                    }
                  }
                } else {
                  CustomSnackbar.error("No station selected");
                }
              },
              titleText: 'Navigate to Station',
              buttonRadius: 12,
            )),
          ),
        ],
      ),
    );
  }
}