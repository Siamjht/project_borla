
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_service.dart';
import '../../models/commonModels/notificationModel/notification_model.dart';
import '../../role/components/customSnackbar/custom_snackbar.dart';
import '../../utils/app_urls.dart';

class NotificationController extends GetxController {
  // State
  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final isPaginationLoading = false.obs;
  final hasError = false.obs;

  // Pagination
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMoreData = true;

  // Scroll controller for pagination trigger
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    _setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  // ─── Setup scroll listener for auto pagination ───────────────────────────
  void _setupScrollListener() {
    scrollController.addListener(() {
      final atBottom = scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200;

      if (atBottom && !isPaginationLoading.value && _hasMoreData) {
        fetchMoreNotifications();
      }
    });
  }

  // ─── Initial / Refresh fetch ──────────────────────────────────────────────
  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _hasMoreData = true;
      notifications.clear();
    }

    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await ApiService.get(
        '${AppUrls.notifications}?page=$_currentPage&limit=$_limit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final meta = NotificationMeta.fromJson(response.body['meta']);

        notifications.assignAll(
          data.map((e) => NotificationModel.fromJson(e)).toList(),
        );

        _hasMoreData = _currentPage < meta.totalPage;
      } else {
        hasError.value = true;
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      hasError.value = true;
      debugPrint('Fetch notifications error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Load next page ───────────────────────────────────────────────────────
  Future<void> fetchMoreNotifications() async {
    if (!_hasMoreData || isPaginationLoading.value) return;

    try {
      isPaginationLoading.value = true;
      _currentPage++;

      final response = await ApiService.get(
        '${AppUrls.notifications}?page=$_currentPage&limit=$_limit',
      );

      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        final meta = NotificationMeta.fromJson(response.body['meta']);

        notifications.addAll(
          data.map((e) => NotificationModel.fromJson(e)).toList(),
        );

        _hasMoreData = _currentPage < meta.totalPage;
      } else {
        _currentPage--; // Revert on failure
        CustomSnackbar.error(response.message);
      }
    } catch (e) {
      _currentPage--;
      debugPrint('Pagination error: $e');
    } finally {
      isPaginationLoading.value = false;
    }
  }

  // ─── Mark single notification as read ────────────────────────────────────
  Future<void> markAsRead(String id) async {
    try {
      final response = await ApiService.patch(
        '${AppUrls.notifications}/$id/read',
      );

      if (response.statusCode == 200) {
        final index = notifications.indexWhere((n) => n.id == id);
        if (index != -1) {
          final updated = NotificationModel(
            id: notifications[index].id,
            receiver: notifications[index].receiver,
            reference: notifications[index].reference,
            modelType: notifications[index].modelType,
            message: notifications[index].message,
            description: notifications[index].description,
            read: true, // ← updated
            isDeleted: notifications[index].isDeleted,
            createdAt: notifications[index].createdAt,
            updatedAt: notifications[index].updatedAt,
          );
          notifications[index] = updated;
        }
      }
    } catch (e) {
      debugPrint('Mark as read error: $e');
    }
  }

  // ─── Mark All notification as read ────────────────────────────────────
  Future<void> markAllAsRead() async {
    try {
      final response = await ApiService.patch(AppUrls.notifications);
      if (response.statusCode == 200) {
        notifications.assignAll(
          notifications.map((n) => NotificationModel(
            id: n.id, receiver: n.receiver, reference: n.reference,
            modelType: n.modelType, message: n.message, description: n.description,
            read: true, isDeleted: n.isDeleted,
            createdAt: n.createdAt, updatedAt: n.updatedAt,
          )).toList(),
        );
      }
    } catch (e) {
      debugPrint('Mark all as read error: $e');
    }
  }

  // ─── Unread count helper ──────────────────────────────────────────────────
  int get unreadCount => notifications.where((n) => !n.read).length;
}