
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_borla/role/components/button/common_button.dart';
import 'package:project_borla/role/components/custom_container.dart';
import 'package:project_borla/role/components/gradient_scafold.dart';
import 'package:project_borla/role/garbageCollector/earnings/innerWidget/recent_transactions.dart';
import 'package:project_borla/theme/app_color.dart';

import '../../../gen/custom_assets/assets.gen.dart';
import '../../components/text/common_text.dart';
import 'controller/earnings_controller.dart';
import 'innerWidget/topup_dialog.dart';
import 'innerWidget/withdraw_dialog.dart';

class EarningsScreen extends StatelessWidget {
  EarningsScreen({super.key});

  final EarningsController _earningCtrl = Get.find<EarningsController>();

  void showWithdrawDialog(BuildContext context, child) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>  child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CommonText(
                  text: 'Earning',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),

              const SizedBox(height: 20),

              /// Tabs
              buildAnimatedTabBar(_earningCtrl),

              const SizedBox(height: 24),

              Obx(() {
                if (_earningCtrl.isLoading.value) {
                  return Container(
                    height: 400.h,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: AppColors.green500,
                    ),
                  );
                }

                final data = _earningCtrl.earningsData.value;
                return Column(
                  children: [
                    /// Balance Card
                    _buildBalanceCard(context, data.balance),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatCard(
                          title: 'Total Earnings',
                          value: 'GH₵ ${data.totalEarnings}',
                          bgColor: AppColors.green50,
                          textColor: AppColors.green500,
                        ),
                        _StatCard(
                          title: 'Ride Completed',
                          value: '${data.rideCompleted}',
                          bgColor: AppColors.blue50,
                          textColor: AppColors.deepBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatCard(
                          title: 'Commission',
                          value: '-GH₵ ${data.commission}',
                          bgColor: AppColors.red50,
                          textColor: AppColors.red500,
                        ),
                        _StatCard(
                          title: 'Cash Received',
                          value: 'GH₵ ${data.cashReceived}',
                          bgColor: AppColors.yellow50,
                          textColor: AppColors.deepOlive,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    RecentTransactionsWidget(transactions: data.transactions),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- TAB BAR ----------------
  Widget buildAnimatedTabBar(EarningsController controller) {
    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      borderRadius: 12,
      color: AppColors.transparent,
      borderColor: AppColors.green100,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// Animated background indicator
            Obx(() {
              return AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _getAlignment(controller.selectedTab.value),
                child: Container(
                  width: Get.width / 3 - 24,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.green500,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              );
            }),

            Row(
              children: const [
                Expanded(child: SizedBox()),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
                Expanded(child: SizedBox()),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
                Expanded(child: SizedBox()),
              ],
            ),


            /// Tabs
            Row(
              children: [
                _TabItem(title: 'Today', index: 0, controller: controller),
                _TabItem(title: 'Weekly', index: 1, controller: controller),
                _TabItem(title: 'Monthly', index: 2, controller: controller),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Alignment _getAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment.centerLeft;
      case 1:
        return Alignment.center;
      case 2:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }

  /// ---------------- BALANCE CARD ----------------
  Widget _buildBalanceCard(BuildContext context, double balance) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'My Balance',
                  color: AppColors.white,
                  fontSize: 16,
                ),
                const SizedBox(height: 8),
                CommonText(
                  text: '\$$balance',
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 20),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          showWithdrawDialog(context, TopUpDialog());
                        },
                        buttonRadius: 8,
                        firstGradient: AppColors.black200,
                        secondGradient: AppColors.black200,
                        titleText: '+ Top Up',
                      ),
                    ),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          showWithdrawDialog(context, WithdrawDialog());
                        },
                        buttonRadius: 8,
                        firstGradient: AppColors.green300,
                        secondGradient: AppColors.green300,
                        titleText: 'Withdraw',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
              child: Center(
                  child: Assets.icons.trasparentStarIcon.image(
                    height: 70, width: 70
                  )
              )
          )
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final int index;
  final EarningsController controller;

  const _TabItem({
    required this.title,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Obx(() {
          final isSelected = controller.selectedTab.value == index;
          return AnimatedScale(
            scale: isSelected ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Center(
              child: CommonText(
                text: title,
                fontSize: 16,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : AppColors.textDark,
              ),
            ),
          );
        }),
      ),
    );
  }
}



class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color bgColor;
  final Color textColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 79.h,
      width: 171.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(100),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonText(
                  text: title,
                  fontSize: 14,
                  color: AppColors.textDark,
                ),
                const SizedBox(height: 8),
                CommonText(
                  text: value,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
              right: 0,
              child: Center(
                  child: Assets.icons.shadowStarIcon.image(
                      color: textColor,
                    height: 40,
                    width: 40
                  )
              )
          )
        ],
      ),
    );
  }
}
