
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
  final RxInt unreadCount = 0.obs;

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
        final meta = NotificationMeta.fromJson(response.body['meta'] ?? {});

        notifications.assignAll(
          data.map((e) => NotificationModel.fromJson(e)).toList(),
        );

        unreadCount.value = meta.unreadCount;
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
        final meta = NotificationMeta.fromJson(response.body['meta'] ?? {});

        notifications.addAll(
          data.map((e) => NotificationModel.fromJson(e)).toList(),
        );

        unreadCount.value = meta.unreadCount;
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
        AppUrls.markNotificationByID(id: id),
      );

      if (response.statusCode == 200) {
        final index = notifications.indexWhere((n) => n.id == id);
        if (index != -1) {
          notifications[index] = NotificationModel(
            id: notifications[index].id,
            userId: notifications[index].userId,
            type: notifications[index].type,
            title: notifications[index].title,
            message: notifications[index].message,
            data: notifications[index].data,
            isRead: true,
            createdAt: notifications[index].createdAt,
            updatedAt: notifications[index].updatedAt,
          );
          
          // Decrement unread count
          if (unreadCount.value > 0) {
            unreadCount.value--;
          }
        }
      }
    } catch (e) {
      debugPrint('Mark as read error: $e');
    }
  }

  // ─── Mark all notifications as read ────────────────────────────────────
  Future<void> markAllAsRead() async {
    try {
      final response = await ApiService.patch(AppUrls.readNotifications);
      if (response.statusCode == 200) {
        notifications.assignAll(
          notifications.map((n) => NotificationModel(
            id: n.id,
            userId: n.userId,
            type: n.type,
            title: n.title,
            message: n.message,
            data: n.data,
            isRead: true,
            createdAt: n.createdAt,
            updatedAt: n.updatedAt,
          )).toList(),
        );
        unreadCount.value = 0;
      }
    } catch (e) {
      debugPrint('Mark all as read error: $e');
    }
  }
}