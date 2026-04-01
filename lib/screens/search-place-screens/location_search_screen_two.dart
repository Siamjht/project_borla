import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/text/common_text.dart';
import 'package:project_borla/screens/search-place-screens/search-address-controllers/location_search_controller.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/search-screen-widgets/search_screen_header_widget.dart';


class LocationSearchScreenTwo extends StatefulWidget {
  const LocationSearchScreenTwo({super.key});

  @override
  State<LocationSearchScreenTwo> createState() => _LocationSearchScreenTwoState();
}

class _LocationSearchScreenTwoState extends State<LocationSearchScreenTwo> {
  final LocationSearchTwoController locationSearchCtrl = Get.put(LocationSearchTwoController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(22, 72, 22, 22),
            child: Column(
              children: [
                SearchScreenHeaderSection(),
                SizedBox(height: 36),

                // ── Search Field ──────────────────────────────
                CustomTextField(
                  controller: locationSearchCtrl.addressController,
                  hint: '2nd Crescent Link, Ghana',
                  prefix: Image.asset('assets/images/fourth_pin.png'),
                  suffix: InkWell(
                    onTap: () => locationSearchCtrl.addressController.clear(),
                    child: Image.asset('assets/images/cross.png'),
                  ),
                ),

                // SizedBox(height: 14),
                // SearchScreenTabButtons(),
                SizedBox(height: 22),

                // ── List Header ───────────────────────────────
                Obx(() => locationSearchCtrl.isSearching.value
                    ? const SizedBox()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Places',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    InkWell(
                      onTap: locationSearchCtrl.clearAll,
                      child: Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                )),

                SizedBox(height: 22),

                // ── List Body ─────────────────────────────────
                Expanded(
                  child: Obx(() {

                    // Show suggestions when searching
                    if (locationSearchCtrl.isSearching.value) {
                      if (locationSearchCtrl.isLoadingSuggestions.value) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (locationSearchCtrl.suggestions.isEmpty) {
                        return Center(
                          child: CommonText(
                            text: 'No results found',
                            color: AppColors.gray400,
                            fontSize: 14,
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: locationSearchCtrl.suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = locationSearchCtrl.suggestions[index];
                          return InkWell(
                            onTap: () => locationSearchCtrl.selectSuggestion(suggestion),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: AppColors.gray400),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CommonText(
                                          textAlign: TextAlign.start,
                                          text: suggestion.title,
                                          color: AppColors.gray500,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 4),
                                        CommonText(
                                          textAlign: TextAlign.start,
                                          text: suggestion.address,
                                          color: AppColors.gray400,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    // Show recent searches when not searching
                    if (locationSearchCtrl.recentSearches.isEmpty) {
                      return Center(
                        child: CommonText(
                          text: 'No recent searches',
                          color: AppColors.gray400,
                          fontSize: 14,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: locationSearchCtrl.recentSearches.length,
                      itemBuilder: (context, index) {
                        final recent = locationSearchCtrl.recentSearches[index];
                        return InkWell(
                          onTap: () => locationSearchCtrl.selectRecent(recent),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time,
                                    color: AppColors.gray400),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                        textAlign: TextAlign.start,
                                        text: recent.title,
                                        color: AppColors.gray500,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 8),
                                      CommonText(
                                        textAlign: TextAlign.start,
                                        text: recent.address,
                                        color: AppColors.gray500,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


